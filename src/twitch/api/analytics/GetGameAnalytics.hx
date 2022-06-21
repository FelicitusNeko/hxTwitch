package twitch.api.analytics;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetGameAnalyticsQuery = {
	var ?after:String;
	var ?ended_at:String;
	var ?first:Int;
	var ?game_id:String;
	var ?started_at:String;
	var ?type:String;
}

typedef GetGameAnalyticsRequest = {}

typedef GetGameAnalyticsResponse = Array<{
	var game_id:String;
	var URL:String;
	var type:String;
	var date_range:{
		var started_at:String;
		var ended_at:String;
	}
}>

class GetGameAnalytics extends APIEndpoint {
	static var scopeRequired = "analytics:read:games";
	static var oauthRequired = true;
	static var method = HttpMethod.Get;
	static var endpoint = "analytics/games";

	public static function call(client:Client, query:GetGameAnalyticsQuery):APIResponse<GetGameAnalyticsResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
