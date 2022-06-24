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
  public static varscopeRequired = "channel:manage:broadcast";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "streams/markers";

  public static function call(client:Client, request:CreateStreamMarkerRequest):APIResponse<CreateStreamMarkerResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}