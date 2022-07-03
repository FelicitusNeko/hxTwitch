package twitch.api.polls;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetPollsQuery = {
  var broadcaster_id:String;
  var ?id:String;
  var ?after:String;
  var ?first:String;
}

typedef GetPollsRequest = {
}

typedef GetPollsResponse = Array<{
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

class GetPolls extends APIEndpoint {
  public static var scopeRequired = "channel:read:polls";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "polls";

  public static function call(client:Client, query:GetPollsQuery):APIResponse<GetPollsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}