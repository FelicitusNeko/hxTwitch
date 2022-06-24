package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef BanUserQuery = {
	var broadcaster_id:String;
	var moderator_id:String;
}

typedef BanUserRequest = {
	var user_id:String;
	var reason:String;
	var ?duration:Int;
}

typedef BanUserResponse = Array<{
	var broadcaster_id:String;
	var moderator_id:String;
	var user_id:String;
	var created_at:String;
	var ?end_time:String;
}>

class BanUser extends APIEndpoint {
	public static varscopeRequired = "moderator:manage:banned_users";
	public static varoauthRequired = true;
	public static varmethod = HttpMethod.Post;
	public static varendpoint = "moderation/bans";

	public static function call(client:Client, query:BanUserQuery, request:BanUserRequest):APIResponse<BanUserResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
