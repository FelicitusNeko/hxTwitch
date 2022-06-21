package twitch;

import haxe.http.HttpMethod;
import haxe.io.BytesOutput;
import haxe.Http;

class Client {
	public static final baseURL = "https://api.twitch.tv/helix/";

	var _clientId = "";
	var _clientSecret = "";

	public function new() {}

	public function call(method:HttpMethod, endpoint:String, ?query:Map<String, Dynamic>, ?data:String):String {
		var retval = new BytesOutput();
		var url = baseURL + endpoint;
		var req = new Http(url);
		req.addHeader("Authorization", "Bearer " + _clientSecret);
		req.addHeader("Client-Id", _clientId);
    if (query != null)
      for (k => v in query)
        req.addParameter(k, Std.string(v));
		if (data != null) {
			req.addHeader("Content-Type", "application/json");
			req.setPostData(data);
		}

		//req.customRequest(method != Get, retval, null, method);

		return retval.getBytes().toString();
	}
}
