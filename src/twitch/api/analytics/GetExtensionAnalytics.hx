package twitch.api.analytics;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetExtensionAnalyticsQuery = {
	var ?after:String;
	var ?ended_at:String;
	var ?extension_id:String;
	var ?first:Int;
	var ?started_at:String;
	var ?type:String;
}

typedef GetExtensionAnalyticsRequest = {}

typedef GetExtensionAnalyticsResponse = Array<{
	var extension_id:String;
	var URL:String;
	var type:String;
	var date_range:{
		var started_at:String;
		var ended_at:String;
	}
}>

class GetExtensionAnalytics extends APIEndpoint {
	static var scopeRequired = "analytics:read:extensions";
	static var oauthRequired = true;
	static var method = HttpMethod.Get;
	static var endpoint = "analytics/extensions";

	public static function call(client:Client, query:GetExtensionAnalyticsQuery):APIResponse<GetExtensionAnalyticsResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
