package twitch.api.clips;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CreateClipQuery = {
  var broadcaster_id:String;
  var ?has_delay:Bool;
}

typedef CreateClipRequest = {
}

typedef CreateClipResponse = Array<{
  var id:String;
  var edit_url:String;
}>

class CreateClip extends APIEndpoint {
  public static var scopeRequired = "clips:edit";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Post;
  public static var endpoint = "clips";

  public static function call(client:Client, query:CreateClipQuery):APIResponse<CreateClipResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}