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
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "streams/tags";

  public static function call(client:Client, query:GetStreamTagsQuery):APIResponse<GetStreamTagsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}