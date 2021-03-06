package twitch.api.ads;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef StartCommercialQuery = {};

typedef StartCommercialRequest = {
	var broadcaster_id:String;
	var length:Int;
}

typedef StartCommercialResponse = Array<{
	var length:Int;
	var message:String;
	var retry_after:Int;
}>

class StartCommercial extends APIEndpoint {
	public static var scopeRequired = "channel:edit:commercial";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Post;
	public static var endpoint = "channels/commercial";

	public static function call(client:Client, request:StartCommercialRequest):APIResponse<StartCommercialResponse> {
		return APIEndpoint.call(method, endpoint, client, [], request);
	}
}
