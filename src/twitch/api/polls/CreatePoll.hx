package twitch.api.polls;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CreatePollQuery = {
}

typedef CreatePollRequest = {
  var broadcaster_id:String;
  var title:String;
  var choices:Array<{
    var title:String;
  }>;
  var duration:Int;
  var ?bits_voting_enabled:Bool;
  var ?bits_per_vote:Int;
  var ?channel_points_voting_enabled:Bool;
  var ?channel_points_per_vote:Int;
}

typedef CreatePollResponse = Array<{
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
}>

class CreatePoll extends APIEndpoint {
  public static var scopeRequired = "channel:manage:polls";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Post;
  public static var endpoint = "polls";

  public static function call(client:Client, request:CreatePollRequest):APIResponse<CreatePollResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}