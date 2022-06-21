package twitch.api.hypeTrain;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetHypeTrainEventsQuery = {
  var broadcaster_id:String;
  var ?first:Int;
  var ?cursor:String;
}

typedef GetHypeTrainEventsRequest = {
}

typedef GetHypeTrainEventsResponse = Array<{
  var id:String;
  var event_type:String;
  var event_timestamp:String;
  var version:String;
  var event_data:{
    var broadcaster_id:String;
    var cooldown_end_time:String;
    var expires_at:String;
    var goal:Int;
    var id:String;
    var last_contribution:{
      var total:Int;
      var type:String;
      var user:String;
    };
    var level:Int;
    var started_at:String;
    var top_contributions:Array<{
      var total:Int;
      var type:String;
      var user:String;
    }>;
    var total:Int;
  }
}>

class GetHypeTrainEvents extends APIEndpoint {
  static var scopeRequired = "channel:read:hype_train";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "hypetrain/events";

  public static function call(client:Client, query:GetHypeTrainEventsQuery):APIResponse<GetHypeTrainEventsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}