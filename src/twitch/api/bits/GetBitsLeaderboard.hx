package twitch.api.bits;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetBitsLeaderboardQuery = {
	var ?count:Int;
	var ?period:String;
	var ?started_at:String;
	var ?user_id:String;
}

typedef GetBitsLeaderboardRequest = {}

typedef GetBitsLeaderboardResponse = Array<{
	var user_id:String;
	var user_login:String;
	var user_name:String;
	var rank:Int;
	var score:Int;
}>

class GetBitsLeaderboard extends APIEndpoint {
	public static var scopeRequired = "bits:read";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Get;
	public static var endpoint = "bits/leaderboard";

	public static function call(client:Client, query:GetBitsLeaderboardQuery):APIResponse<GetBitsLeaderboardResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
