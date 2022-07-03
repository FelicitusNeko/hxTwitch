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
	public static var scopeRequired = "moderator:manage:banned_users";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Post;
	public static var endpoint = "moderation/bans";

	public static function call(client:Client, query:BanUserQuery, request:BanUserRequest):APIResponse<BanUserResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
