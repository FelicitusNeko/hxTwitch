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
	public static varscopeRequired = "moderation:read";
	public static varoauthRequired = true;
	public static varmethod = HttpMethod.Post;
	public static varendpoint = "enforcements/status";

	public static function call(client:Client, query:CheckAutoModStatusQuery, request:CheckAutoModStatusRequest):APIResponse<CheckAutoModStatusResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
