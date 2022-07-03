package twitch.api.streams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CreateStreamMarkerQuery = {
}

typedef CreateStreamMarkerRequest = {
  var user_id:String;
  var ?description:String;
}

typedef CreateStreamMarkerResponse = Array<{
  var id:String;
  var created_at:String;
  var description:String;
  var position_seconds:Int;
}>

class CreateStreamMarker extends APIEndpoint {
  public static var scopeRequired = "channel:manage:broadcast";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Post;
  public static var endpoint = "streams/markers";

  public static function call(client:Client, request:CreateStreamMarkerRequest):APIResponse<CreateStreamMarkerResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}