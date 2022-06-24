package twitch.api.schedule;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateChannelStreamScheduleSegmentQuery = {
	var broadcaster_id:String;
	var id:String;
}

typedef UpdateChannelStreamScheduleSegmentRequest = {
	var ?start_time:String;
	var ?duration:String;
	var ?category_id:String;
	var ?title:String;
	var ?is_canceled:Bool;
	var ?timezone:String;
}

typedef UpdateChannelStreamScheduleSegmentResponse = Array<{
	var segments:Array<{
		var id:String;
		var start_time:String;
		var end_time:String;
		var title:String;
		var ?canceled_until:String;
		var ?category:{
			var id:String;
			var name:String;
		}
		var is_recurring:Bool;
	}>;
	var broadcaster_id:String;
	var broadcaster_name:String;
	var broadcaster_login:String;
	var ?vaction:{
		var start_time:String;
		var end_time:String;
	};
}>

class UpdateChannelStreamScheduleSegment extends APIEndpoint {
	public static varscopeRequired = "channel:manage:schedule";
	public static varoauthRequired = true;
	public static varmethod = HttpMethod.Patch;
	public static varendpoint = "schedule/segment";

	public static function call(client:Client, query:UpdateChannelStreamScheduleSegmentQuery,
			request:UpdateChannelStreamScheduleSegmentRequest):APIResponse<UpdateChannelStreamScheduleSegmentResponse> {
		return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
	}
}
