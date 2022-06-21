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
	static var scopeRequired = "bits:read";
	static var oauthRequired = true;
	static var method = HttpMethod.Get;
	static var endpoint = "bits/leaderboard";

	public static function call(client:Client, query:GetBitsLeaderboardQuery):APIResponse<GetBitsLeaderboardResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
