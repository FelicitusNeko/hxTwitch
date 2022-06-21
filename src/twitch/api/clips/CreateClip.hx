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
  static var scopeRequired = "clips:edit";
  static var oauthRequired = true;
  static var method = HttpMethod.Post;
  static var endpoint = "clips";

  public static function call(client:Client, query:CreateClipQuery):APIResponse<CreateClipResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}