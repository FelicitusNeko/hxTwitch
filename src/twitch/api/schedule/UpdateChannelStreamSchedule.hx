package twitch.api.schedule;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UpdateChannelStreamScheduleQuery = {
  var broadcaster_id:String;
  var ?is_vacation_enabled:Bool;
  var ?vacation_start_time:String;
  var ?vacation_end_time:String;
  var ?timezone:String;
}

typedef UpdateChannelStreamScheduleRequest = {
}

typedef UpdateChannelStreamScheduleResponse = {}

class UpdateChannelStreamSchedule extends APIEndpoint {
  public static var scopeRequired = "channel:manage:schedule";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Patch;
  public static var endpoint = "schedule/settings";

  public static function call(client:Client, query:UpdateChannelStreamScheduleQuery):APIResponse<UpdateChannelStreamScheduleResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}