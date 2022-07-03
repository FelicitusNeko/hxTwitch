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
	public static var scopeRequired = "channel:manage:schedule";
	public static var oauthRequired = true;
	public static var method = HttpMethod.Delete;
	public static var endpoint = "schedule/segment";

	public static function call(client:Client, query:DeleteChannelStreamScheduleSegmentQuery):APIResponse<DeleteChannelStreamScheduleSegmentResponse> {
		return APIEndpoint.call(method, endpoint, client, query);
	}
}
