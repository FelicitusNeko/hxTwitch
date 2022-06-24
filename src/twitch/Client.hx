package twitch;

import haxe.Json;
import haxe.Exception;
import haxe.http.HttpMethod;
import haxe.io.BytesOutput;
import haxe.Http;

typedef RawAPIResponse = {
	var code:Int;
	var ?text:String;
}

class Client {
	public static final baseURL = "https://api.twitch.tv/helix/";

	var _clientId = "";
	var _clientSecret = "";

	public function new(clientId:String, clientSecret:String) {
		_clientId = clientId;
		_clientSecret = clientSecret;
	}

	public function call(method:HttpMethod, endpoint:String, ?query:Map<String, Dynamic>, ?data:String):RawAPIResponse {
		var retval = new BytesOutput();
		var url = baseURL + endpoint;
		var req = new Http(url);
		var code = -1;

		req.onStatus = codeIn -> code = codeIn;
		req.onError = error -> throw new Exception(error);

		req.addHeader("Client-Id", _clientId);
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
}
