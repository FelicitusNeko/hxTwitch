package twitch.api.streams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetStreamsQuery = {
  var ?after:String;
  var ?before:String;
  var ?first:Int;
  var ?game_id:String;
  var ?language:String;
  var ?user_id:String;
  var ?user_login:String;
}

typedef GetStreamsRequest = {
}

typedef GetStreamsResponse = Array<{
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
  var is_mature:Bool;
}>

class GetStreams extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "streams";

  public static function call(client:Client, query:GetStreamsQuery):APIResponse<GetStreamsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}