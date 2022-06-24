package twitch.api.videos;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef DeleteVideosQuery = {
  var id:String;
}

typedef DeleteVideosRequest = {
}

typedef DeleteVideosResponse = Array<String>;

class DeleteVideos extends APIEndpoint {
  public static var scopeRequired = "channel:manage:videos";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Delete;
  public static var endpoint = "videos";

  public static function call(client:Client, query:DeleteVideosQuery):APIResponse<DeleteVideosResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}