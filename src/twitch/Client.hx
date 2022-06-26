package twitch;

import haxe.Timer;
import haxe.macro.Expr.Error;
import twitch.pubsub.PubSubIncomingMessage;
import hx.ws.WebSocket;
import haxe.Json;
import haxe.Exception;
import haxe.http.HttpMethod;
import haxe.io.BytesOutput;
import haxe.Http;

/** The raw representation of data received from the API. **/
typedef RawAPIResponse = {
	/** The HTTP status code returned. **/
	var code:Int;
	/** The body of the response, if the HTTP code is not 204 (No Content). **/
	var ?text:String;
}

/** The Twitch API, PubSub, and Chat client. **/
class Client {
	//------------- Statics

	/** The base URL for the API. **/
	public static final baseURL = "https://api.twitch.tv/helix/";

	/** The URL for connecting to PubSub. **/
	public static final pubSubURL = "wss://pubsub-edge.twitch.tv";

	/** The URL for connecting to the chat server. **/
	public static final chatURL = "wss://chat.twitch.tv";

	//------------- General use variables

	/** The client ID (similar to username) for this client. **/
	var _clientId = "";

	/** The client secret (similar to password) for this client. **/
	var _clientSecret = "";

	/** The OAuth key for this client, which determines what it has access to. Externally write-only. **/
	public var _oauthKey(null, default):Null<String> = null;

	/** Generates a random 16-character nonce. **/
	var _genNonce(get, never):String;

	//------------- PubSub variables

	/** The websocket that will connect to the PubSub server. **/
	var _ps_ws:WebSocket = null;

	/** The list of PubSub topics the client is listening to, and their callbacks. **/
	var _ps_listen:Map<String, PubSubIncomingMessage->Void> = [];

	/** The list of nonces sent to PubSub yet to be confirmed. **/
	var _ps_checkNonce:Map<String, String> = [];

	/** Sends a PING message to the PubSub server once every three minutes. **/
	var _ps_pinger:Timer = null;

	/** The function to call when the client connects to the PubSub server. **/
	public var onPSConnect:Void->Void = null;

	//------------- Chat variables

	// nothing here yet

	public function new(clientId:String, clientSecret:String) {
		_clientId = clientId;
		_clientSecret = clientSecret;
	}

	function get__genNonce():String {
		var text = "";
		var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		for (_ in 0...16)
			text += possible.charAt(Math.floor(Math.random() * possible.length));
		return text;
	}

	/**
		Calls a Twitch API endpoint. It is recommended not to call this directly, but rather to use the endpoint definers (e.g. `twitch.api.users.GetUsers`).
		@param method The request method to be used.
		@param endpoint The endpoint path to call.
		@param query Optional. The list of query parameters to be added to the URL.
		@param data Optional. The body of the request.
		@return The data returned by the API endpoint.
	**/
	public function call(method:HttpMethod, endpoint:String, ?query:Map<String, Dynamic>, ?data:String):RawAPIResponse {
		var retval = new BytesOutput();
		var url = baseURL + endpoint;
		var req = new Http(url);
		var code = -1;

		req.onStatus = codeIn -> code = codeIn;
		req.onError = error -> throw new Exception(error);

		req.addHeader("Client-Id", _clientId);
		if (_oauthKey != null)
			req.addHeader("Authorization", "OAuth " + _oauthKey);
		else
			req.addHeader("Authorization", "Bearer " + _clientSecret);
		if (query != null)
			for (k => v in query)
				req.addParameter(k, Std.string(v));

		if (data != null) {
			req.addHeader("Content-Type", "application/json");
			req.setPostData(data);
		}

		req.customRequest(method != Get, retval, null, method);

		if (code >= 400 || code <= 500) {
			var errorData:Dynamic = Json.parse(retval.getBytes().toString());
			throw new APIException(errorData.message, code, errorData);
		}

		return {
			code: code,
			text: code == 204 ? null : retval.getBytes().toString()
		};
	}

	/** Connects to the PubSub server. **/
	private function connectPubSub() {
		/** The server should PONG the PING within ten seconds. If not, reconnect to the server. **/
		var timeout:Timer = null;

		if (_ps_ws != null)
			_ps_ws.close();
		if (_oauthKey == null)
			throw new Exception("Client must be authenticated with OAuth key to connect to PubSub");
		_ps_listen.clear();
		_ps_checkNonce.clear();

		_ps_ws = new WebSocket(pubSubURL);
		_ps_ws.additionalHeaders.set("Client-ID", _clientId);
		_ps_ws.additionalHeaders.set("Authorization", "OAuth " + _oauthKey);

		_ps_ws.onopen = () -> {
			_ps_pinger = new Timer(180000);
			_ps_pinger.run = () -> {
				if (_ps_ws == null || _ps_ws.state == Closed) {
					_ps_pinger.stop();
					_ps_pinger = null;
				} else {
					_ps_ws.send(Json.stringify({type: "PING"}));
					timeout = new Timer(10000);
					timeout.run = () -> {
						timeout.stop();
						connectPubSub();
					}
				}
			}
			if (onPSConnect != null)
				onPSConnect();
		}

		_ps_ws.onmessage = msg -> {
			switch (msg) {
				case StrMessage(content):
					var msgObj:PubSubIncomingMessage = Json.parse(content);
					if (msgObj.type != null) switch (msgObj.type) {
						case "RESPONSE":
							if (msgObj.nonce != null) {
								if (msgObj.error != null && msgObj.error != "")
									_ps_listen.remove(_ps_checkNonce[msgObj.nonce]);
								_ps_checkNonce.remove(msgObj.nonce);
							}
						case "MESSAGE":
							if (msgObj.data != null && _ps_listen.exists(msgObj.data.topic)) _ps_listen[msgObj.data.topic](msgObj);
						case "RECONNECT":
							connectPubSub();
						case "PONG":
							timeout.stop();
					}
				default:
			}
		}

		_ps_ws.onerror = err -> throw new Exception("WS error: " + Std.string(err));

		_ps_ws.onclose = () -> {
			if (_ps_pinger != null) {
				_ps_pinger.stop();
				_ps_pinger = null;
			}
			_ps_ws = null;
			_ps_listen.clear();
			_ps_checkNonce.clear();
		}

		_ps_ws.open();
	}

	/**
		Listens to a topic on PubSub. If the client is not connected to PubSub, it also does so.
		It is recommended not to call this directly, and rather, to use the PubSub topic definers (e.g. `twitch.pubsub.bits.ChannelBitsEventsV2`).
		@param topic The topic string to listen to.
		@param callback The function to be called when a message is received on this topic.
		@throws Exception Throws an exception if the client does not have an OAuth token.
		@throws Exception Throws an exception if the client is already subscribed to that topic.		
	**/
	public function psListen(topic:String, callback:PubSubIncomingMessage->Void) {
		if (_ps_listen.exists(topic))
			throw new Exception("Already subscribed to topic " + topic);

		if (_ps_ws == null || _ps_ws.state == Closed)
			connectPubSub();

		var nonce = _genNonce;
		_ps_checkNonce.set(nonce, topic);
		_ps_ws.send(Json.stringify({
			type: "LISTEN",
			nonce: nonce,
			data: {
				topics: [topic],
				auth_token: _oauthKey
			}
		}));
	}

	/**
		Terminates the listener for a topic on PubSub. If the client is no longer connected to any topics, it will also close the PubSub connection.
		It is recommended not to call this directly, and rather, to use the PubSub topic definers (e.g. `twitch.pubsub.bits.ChannelBitsEventsV2`).
		@param topic The topic string to stop listening to.
		@throws Exception Throws an exception if the client is not subscribed to that topic.
	**/
	public function psUnlisten(topic:String) {
		if (_ps_ws == null || _ps_ws.state == Closed)
			return;

		if (!_ps_listen.exists(topic))
			throw new Exception("Not listening to topic " + topic);

		_ps_ws.send(Json.stringify({
			type: "UNLISTEN",
			data: {
				topics: [topic]
			}
		}));
		_ps_listen.remove(topic);

		var count = 0;
		for (_ in _ps_listen) count++;
		if (count == 0) _ps_ws.close();
	}
}
