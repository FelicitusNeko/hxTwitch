package twitch.api.schedule;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef DeleteChannelStreamScheduleSegmentQuery = {
	var broadcaster_id:String;
	var id:String;
}

typedef DeleteChannelStreamScheduleSegmentRequest = {}

typedef DeleteChannelStreamScheduleSegmentResponse = {}

class DeleteChannelStreamScheduleSegment extends APIEndpoint {
	public static varscopeRequired = "channel:manage:schedule";
	public static varoauthRequired = true;
	public static varmethod = HttpMethod.Delete;
	public static varendpoint = "schedule/segment";

	public static function call(client:Client, query:DeleteChannelStreamScheduleSegmentQuery):APIResponse<DeleteChannelStreamScheduleSegmentResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
