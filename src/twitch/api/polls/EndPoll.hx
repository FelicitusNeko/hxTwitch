package twitch.api.polls;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef EndPollQuery = {
}

typedef EndPollRequest = {
  var broadcaster_id:String;
  var id:String;
  var status:String;
}

typedef EndPollResponse = Array<{
  var id:String;
  var broadcaster_id:String;
  var broadcaster_login:String;
  var broadcaster_name:String;
  var title:String;
  var choices:Array<{
    var id:String;
    var title:String;
    var votes:Int;
    var channel_points_votes:Int;
    var bits_votes:Int;
  }>;
  var bits_voting_enabled:Bool;
  var bits_per_vote:Int;
  var channel_points_voting_enabled:Bool;
  var channel_points_per_vote:Int;
  var status:String;
  var duration:Int;
  var started_at:String;
  var ended_at:String;
}>

class EndPoll extends APIEndpoint {
  public static varscopeRequired = "channel:manage:polls";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Patch;
  public static varendpoint = "polls";

  public static function call(client:Client, request:EndPollRequest):APIResponse<EndPollResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}