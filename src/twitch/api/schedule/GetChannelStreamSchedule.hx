package twitch.api.schedule;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetChannelStreamScheduleQuery = {
  var broadcaster_id:String;
  var ?id:String;
  var ?start_time:String;
  var ?utc_offset:String;
  var ?first:String;
  var ?after:String;
}

typedef GetChannelStreamScheduleRequest = {
}

typedef GetChannelStreamScheduleResponse = Array<{
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

class GetChannelStreamSchedule extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "schedule";

  public static function call(client:Client, query:GetChannelStreamScheduleQuery):APIResponse<GetChannelStreamScheduleResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}