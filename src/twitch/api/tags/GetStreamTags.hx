package twitch.api.tags;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetStreamTagsQuery = {
  var broadcaster_id:String;
}

typedef GetStreamTagsRequest = {
}

typedef GetStreamTagsResponse = Array<{
  var tag_id:String;
  var is_auto:Bool;
  var localization_names:Map<String, String>;
  var localization_descriptions:Map<String, String>;
}>

class GetStreamTags extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "streams/tags";

  public static function call(client:Client, query:GetStreamTagsQuery):APIResponse<GetStreamTagsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}