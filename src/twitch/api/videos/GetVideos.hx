package twitch.api.videos;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetVideosQuery = {
  var ?id:String;
  var ?user_id:String;
  var ?game_id:String;
  var ?first:Int;
  var ?after:String;
  var ?before:String;
  var ?language:String;
  var ?period:String;
  var ?sort:String;
  var ?type:String;
}

typedef GetVideosRequest = {
}

typedef GetVideosResponse = Array<{
  var id:String;
  var ?stream_id:String;
  var user_id:String;
  var user_login:String;
  var user_name:String;
  var title:String;
  var description:String;
  var created_at:String;
  var published_at:String;
  var url:String;
  var thumbnail_url:String;
  var view_count:Int;
  var language:String;
  var type:String;
  var duration:String;
  var ?muted_segments:Array<{
    var offset:Int;
    var duration:Int;
  }>;
}>

class GetVideos extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "videos";

  public static function call(client:Client, query:GetVideosQuery):APIResponse<GetVideosResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}