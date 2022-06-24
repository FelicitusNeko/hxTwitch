package twitch.api.streams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetFollowedStreamsQuery = {
  var user_id:String;
  var ?first:Int;
  var ?after:String;
}

typedef GetFollowedStreamsRequest = {
}

typedef GetFollowedStreamsResponse = Array<{
  var id:String;
  var user_id:String;
  var user_login:String;
  var user_name:String;
  var game_id:String;
  var game_name:String;
  var type:String;
  var title:String;
  var viewer_count:Int;
  var started_at:String;
  var language:String;
  var thumbnail_art:String;
  var tags_ids:Array<String>;
}>

class GetFollowedStreams extends APIEndpoint {
  public static varscopeRequired = "user:read:follows";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "streams/followed";

  public static function call(client:Client, query:GetFollowedStreamsQuery):APIResponse<GetFollowedStreamsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}