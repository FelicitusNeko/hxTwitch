package twitch;

import haxe.Exception;
import haxe.Http;
import haxe.http.HttpMethod;
import haxe.io.BytesOutput;
import haxe.Json;
import haxe.Timer;
import hx.ws.WebSocket;
import twitch.chat.ChatSayType;
import twitch.pubsub.PubSubIncomingMessage;

using StringTools;

/** The raw representation of data received from the API. **/
typedef RawAPIResponse = {
	/** The HTTP status code returned. **/
	var code:Int;

	/** The body of the response, if the HTTP code is not 204 (No Content). **/
	var ?text:String;
}

/** Response data for a successful app access token request. **/
typedef AppAccessResponse = {
	/** The app access token. **/
	var access_token:String;

	/** The number of seconds until the token expires. **/
	var expires_in:Int;

	/** The type of token, usually `"bearer"`. **/
	var token_type:String;
}

/** Determines the type of authentication to be used for an API call. **/
enum AuthenticationType {
	/** Will first use OAuth if available; otherwise, will use the app access token. This is the default behaviour. **/
	OAuthFirst;
	/** Will first use OAuth if available; otherwise, will use the app access token. **/
	AppAccessFirst;
	/** Forces the use of the OAuth token. **/
	OAuth;
	/** Forces the use of the app access token. **/
	AppAccess;
}

/** The Twitch API, PubSub, and Chat client. **/
class Client {
	//------------- Statics

	/** The URL for obtaining an app access token. **/
	public static final appAccessURL = "https://id.twitch.tv/oauth2/token";

	/** The URL for obtaining an OAuth token. **/
	public static final oauthURL = "https://id.twitch.tv/oauth2/authorize";

	/** The base URL for the API. **/
	public static final baseURL = "https://api.twitch.tv/helix/";

	/** The URL for connecting to PubSub. **/
	public static final pubSubURL = "wss://pubsub-edge.twitch.tv";

	/** The URL for connecting to the chat server. **/
	public static final chatURL = "wss://irc-ws.chat.twitch.tv";

	// public static final chatURL = "ws://irc-ws.chat.twitch.tv";
	//------------- General use variables

	/** The client ID (similar to username) for this client. **/
	private var _clientId = "";

	/** The client secret (similar to password) for this client. **/
	private var _clientSecret = "";

	/** Write-only. The app access token for this client, which allows it to access certain endpoints where explicit permission is not required. **/
	public var _appToken(null, default):Null<String> = null;

	/** Write-only. The OAuth key for this client, which determines what it has access to. **/
	public var _oauthKey(null, default):Null<String> = null;

	/** Generates a random 16-character nonce. **/
	public var genNonce(get, never):String;

	//------------- PubSub variables

	/** The websocket that will connect to the PubSub server. **/
	private var _ps_ws:WebSocket = null;

	/** The list of PubSub topics the client is listening to, and their callbacks. **/
	private var _ps_listen:Map<String, PubSubIncomingMessage->Void> = [];

	/** The list of nonces sent to PubSub yet to be confirmed. **/
	private var _ps_checkNonce:Map<String, String> = [];

	/** Sends a PING message to the PubSub server once every three minutes. **/
	private var _ps_pinger:Timer = null;

	/** The function to call when the client connects to the PubSub server. **/
	public var onPSConnect:Void->Void = null;

	//------------- Chat variables

	/** The scope(s) required for the chat client to function in authenticated mode.**/
	public static final irc_scope = ["chat:read", "chat:edit"];

	/** The websocket that will connect to the IRC server. **/
	private var _irc_ws:WebSocket = null;

	/** Whether the current chat session is anonymous. `null` if it is not connected. **/
	public var irc_isAnonymous:Null<Bool> = null;

	/** The function to call when the client connects to the chat server and authentication has succeeded. **/
	public var onChatConnect:Void->Void = null;

	/** The function to call when the client is disconnected from the chat server. **/
	public var onChatDisconnect:Void->Void = null;

	/** The list of IRC listeners. **/
	private var _irc_listen:Map<String, String->Void> = [];

	//------------- General functions

	public function new(clientId:String, clientSecret:String) {
		_clientId = clientId;
		_clientSecret = clientSecret;

		chatListen = _irc_listen.set;
		chatUnlisten = _irc_listen.remove;
	}

	function get_genNonce():String {
		var text = "";
		var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		for (_ in 0...16)
			text += possible.charAt(Math.floor(Math.random() * possible.length));
		return text;
	}

	/**
		Generates an OAuth URL with the given set of scopes.
		@param scopes The scopes to request.
		@param redirectURI Optional. The URI to which the authorization page will redirect. Defaults to `http://localhost:3000`.
		@return The URI to use for OAuth authorization.
	**/
	public function genOAuthURL(scopes:Array<String>, redirectURI = "http://locahost:3000") {
		var queryStr:Array<String> = [];

		for (k => v in [
			"response_type" => "token",
			"client_id" => _clientId,
			"redirect_url" => redirectURI,
			"scope" => scopes.join("+"),
			"state" => genNonce
		])
			queryStr.push('${k.urlEncode()}=${v.urlEncode()}');

		return '$oauthURL?${queryStr.join("&")}';
	}

	// TODO: listener for OAuth requests
	//------------- API functions

	/**
		Calls a Twitch API endpoint. It is recommended not to call this directly, but rather to use the endpoint definers (e.g. `twitch.api.users.GetUsers`).
		@param method The request method to be used.
		@param endpoint The endpoint path to call.
		@param query Optional. The list of query parameters to be added to the URL.
		@param data Optional. The body of the request.
		@return The data returned by the API endpoint.
	**/
	public function call(method:HttpMethod, endpoint:String, ?query:Map<String, Dynamic>, ?data:String, authType = OAuthFirst):RawAPIResponse {
		var retval = new BytesOutput();
		var url = baseURL + endpoint;
		var req = new Http(url);
		var code = -1;

		trace(url, method, query, data);

		req.onStatus = codeIn -> code = codeIn;
		// req.onError = error -> {
		// 	trace("Error on API call: " + error);
		// 	throw new Exception(error);
		// }

		//trace("Populating authentication");
		req.addHeader("Client-Id", _clientId);
		// TODO: implement authType
		if (_oauthKey != null)
			req.addHeader("Authorization", 'OAuth $_oauthKey');
		else if (_appToken != null)
			req.addHeader("Authorization", 'Bearer $_appToken');
		else
			throw new Exception("No authentication key provided");

		if (query != null) {
			//trace("Populating query string");
			for (k => v in query)
				req.addParameter(k, Std.string(v));
		}

		if (data != null) {
			//trace("Populating request body");
			req.addHeader("Content-Type", "application/json");
			req.setPostData(data);
		}

		//trace("Deploying request");
		req.customRequest(method != Get, retval, null, method);

		if (code >= 400 && code <= 599) {
			trace('Error code $code was returned.');
			var errorData:Dynamic = Json.parse(retval.getBytes().toString());
			throw new APIException(errorData.message, code, errorData);
		}

		//trace("Request succeeded. Returning result as string");
		return {
			code: code,
			text: code == 204 ? null : retval.getBytes().toString()
		};
	}

	public function getAppAccessToken() {
		var req = new Http(appAccessURL);
		var postStr:Array<String> = [];
		var code = -1;
		var response:AppAccessResponse = null;

		for (k => v in [
			"client_id" => _clientId,
			"client_secret" => _clientSecret,
			"grant_type" => "client_credentials"
		])
			postStr.push('${k.urlEncode()}=${v.urlEncode()}');

		req.addHeader("Content-Type", "application/x-www-form-urlencoded");
		// trace(postStr.join("&"));
		req.setPostData(postStr.join("&"));

		req.onStatus = codeIn -> code = codeIn;
		req.onError = error -> throw new Exception(error);
		req.onData = data -> response = Json.parse(data);

		req.request(true);

		if (response != null)
			_appToken = response.access_token;

		return response;
	}

	//------------- PubSub functions

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

		_ps_ws = new WebSocket(pubSubURL, false);
		_ps_ws.additionalHeaders.set("Client-ID", _clientId);
		_ps_ws.additionalHeaders.set("Authorization", 'OAuth $_oauthKey');

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
			throw new Exception('Already subscribed to topic $topic');

		if (_ps_ws == null || _ps_ws.state == Closed)
			connectPubSub();

		var nonce = genNonce;
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
			throw new Exception('Not listening to topic $topic');

		_ps_ws.send(Json.stringify({
			type: "UNLISTEN",
			data: {
				topics: [topic]
			}
		}));
		_ps_listen.remove(topic);

		var count = 0;
		for (_ in _ps_listen)
			count++;
		if (count == 0)
			_ps_ws.close();
	}

	//------------- Chat functions

	/**
		Properly terminates and concatenates IRC messages to be sent.
		@param messages The messages to send.
	**/
	private function _ircSend(...messages:String) {
		if (_irc_ws != null && _irc_ws.state != Closed) {
			// trace("Sending: " + messages.toArray());
			for (message in messages)
				_irc_ws.send(message /* + "\r\n"*/);
			// _irc_ws.send(messages.toArray().map(i -> i + "\r\n").join(""));
		}
	}

	/**
		Connects to the IRC chat server.
		@param name Optional. The username associated with the given OAuth token. If a username is not provided, the client will connect in anonymous mode.
		@throws Exception Throws an exception if trying to log in non-anonymously without an OAuth token.
	**/
	public function chatConnect(?name:String) {
		// trace("chatConnect()");

		if (_irc_ws != null)
			_irc_ws.close();
		if (_oauthKey == null && name != null)
			throw new Exception("Client must be authenticated with OAuth key to connect to chat");

		_irc_ws = new WebSocket(chatURL, false);
		_irc_ws.additionalHeaders.set("Client-ID", _clientId);

		irc_isAnonymous = name != null;

		_irc_ws.onopen = () -> {
			// trace("Chat WS open");
			var caps = ["twitch.tv/commands", "twitch.tv/tags", "twitch.tv/membership"];
			if (name == null) {
				trace("Authenticating as anonymous user");
				var randnum = 10000 + Math.floor(Math.random() * 989999);
				_ircSend('CAP REQ :${caps.join(" ")}', "PASS oauth:000", 'NICK justinfan$randnum');
			} else {
				trace("Authenticating as " + name);
				_ircSend('CAP REQ :${caps.join(" ")}', 'PASS oauth:$_oauthKey', 'NICK $name');
			}
		}

		_irc_ws.onmessage = msg -> {
			switch (msg) {
				case StrMessage(content):
					var messages = StringTools.rtrim(content).split("\r\n");
					// trace("Received: " + messages);
					var type = "";
					for (message in messages) {
						// TODO: parse out the message before acting on it, even if it's a PING
						var tokens = message.split(" ");
						for (token in tokens)
							if (!["@", ":"].contains(token.charAt(0))) {
								type = token;
								break;
							}
						if (type == "001" && onChatConnect != null)
							onChatConnect();

						if (type == "PING")
							_ircSend(StringTools.replace(message, "PING", "PONG"));
						else if (type == "RECONNECT") {
							trace("IRC server has requested the client to reconnect; doing so automatically");
							chatConnect(name);
						} else if (_irc_listen.exists(type))
							_irc_listen[type](message);
						else if (_irc_listen.exists("*"))
							_irc_listen["*"](message);
					}
				case BytesMessage(content):
					// this shouldn't happen, but just in case it does
					trace("---------- RECEIVED UNSUPPORTED BYTES MESSAGE: " + content.readAllAvailableBytes().toString());
			}
		}

		_irc_ws.onerror = err -> {
			trace('Chat connection error: $err');
			throw new Exception('WS IRC error: ${Std.string(err)}');
		}

		_irc_ws.onclose = () -> {
			trace("Chat connection closed");
			irc_isAnonymous = null;
			_irc_ws = null;
			if (onChatDisconnect != null)
				onChatDisconnect();
		}

		trace("Starting connection");
		_irc_ws.open();
	}

	/**
		Listens to a given IRC message type.
		@param type The type of message to listen for. `"*"` can be used as a fallback catchall.
		@param func The callback function for this type.
	**/
	public var chatListen(default, null):(String, String->Void) -> Void;

	/**
		Stops listening for a given IRC message type.
		@param type The type of message to stop listening for.
		@return Whether a listener was removed. If `false`, there was no listener for this message type.
	**/
	public var chatUnlisten(default, null):String->Bool;

	/**
		Join one or more channels.
		@param channels The channel(s) to be joined. Channels may or may not be prefixed with `#`.
		@throws Exception Throws an exception if not connected to chat.
	**/
	public function chatJoin(...channels:String) {
		if (irc_isAnonymous == null)
			throw new Exception("Not connected to chat");

		var channelsArray:Array<String> = channels.toArray();
		for (i => channel in channelsArray)
			if (channel.charAt(0) != "#")
				channelsArray[i] = '#$channel';
		_ircSend('JOIN ${channelsArray.join(",")}');
	}

	/**
		Leave one or more channels.
		@param channels The channel(s) to leave. Channels may or may not be prefixed with `#`.
		@throws Exception Throws an exception if not connected to chat.
	**/
	public function chatPart(...channels:String) {
		if (irc_isAnonymous == null)
			throw new Exception("Not connected to chat");

		var channelsArray:Array<String> = channels.toArray();
		for (i => channel in channelsArray)
			if (channel.charAt(0) != "#")
				channelsArray[i] = '#$channel';
		_ircSend('PART ${channelsArray.join(",")}');
	}

	/**
		Say something to a user or in a channel.
		@param recipient The recipient of the message. May be a user or a channel. Channels must be prefixed with `#`.
		@param message The message to send.
		@param messageType Optional. The type of message to be sent. Note that announcements require moderator privileges. Defaults to `Say`.
		@param replyTo Optional. The ID of the message which is being replied. Ignored if `messageType` is `Announce`.
		@throws Exception Throws an exception if not connected to chat, or if connected anonymously.
	**/
	public function chatSay(recipient:String, message:String, messageType:ChatSayType = Say, ?replyTo:String) {
		if (irc_isAnonymous == null)
			throw new Exception("Not connected to chat");
		if (irc_isAnonymous == true)
			throw new Exception("Cannot send messages while anonymous");

		var recipientIsChannel = recipient.charAt(0) == "#";
		var replyTag = (!recipientIsChannel || replyTo == null) ? "" : '@reply-parent-msg-id=$replyTo ';

		switch (messageType) {
			case Say:
				_ircSend('${replyTag}PRIVMSG $recipient :$message');
			case Action:
				_ircSend('${replyTag}PRIVMSG $recipient :\001ACTION $message\001');
			case Announce:
				if (!recipientIsChannel)
					throw new Exception("Cannot /announce to a user; must be a channel");
				_ircSend('PRIVMSG $recipient :/announce $message');
		}
	}
}
