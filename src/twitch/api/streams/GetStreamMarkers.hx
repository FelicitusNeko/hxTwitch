package twitch.api.streams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetStreamMarkersQuery = {
  var user_id:String;
  var video_id:String;
  var ?first:Int;
  var ?after:String;
  var ?before:String;
}

typedef GetStreamMarkersRequest = {
}

typedef GetStreamMarkersResponse = Array<{
  var user_id:String;
  var user_login:String;
  var user_name:String;
  var videos:Array<{
    var video_id:String;
    var markers:Array<{
      var id:String;
      var created_at:String;
      var description:String;
      var position_seconds:Int;
      var URL:String;
    }>;
  }>;
}>

class GetStreamMarkers extends APIEndpoint {
  public static var scopeRequired = "user:read:broadcast";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "streams/markers";

  public static function call(client:Client, query:GetStreamMarkersQuery):APIResponse<GetStreamMarkersResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}