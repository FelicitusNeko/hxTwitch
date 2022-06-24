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
  public static varscopeRequired = "clips:edit";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "clips";

  public static function call(client:Client, query:CreateClipQuery):APIResponse<CreateClipResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}