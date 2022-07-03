package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CheckAutoModStatusQuery = {
	var broadcaster_id:String;
}

typedef CheckAutoModStatusRequest = {
	var msg_id:String;
	var msg_text:String;
	var user_id:String;
}

typedef CheckAutoModStatusResponse = Array<{
	var msg_id:String;
	var is_permitted:Bool;
}>

class CheckAutoModStatus extends APIEndpoint {
	public static var scopeRequired = "moderation:read";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Post;
	public static var endpoint = "enforcements/status";

	public static function call(client:Client, query:CheckAutoModStatusQuery, request:CheckAutoModStatusRequest):APIResponse<CheckAutoModStatusResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
