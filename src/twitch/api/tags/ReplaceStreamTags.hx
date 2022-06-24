package twitch.api.tags;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef ReplaceStreamTagsQuery = {
  var broadcaster_id:String;
}

typedef ReplaceStreamTagsRequest = {
  var ?tag_ids:Array<String>;
}

typedef ReplaceStreamTagsResponse = Array<{
}>

class ReplaceStreamTags extends APIEndpoint {
  public static varscopeRequired = "channel:manage:broadcast";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Put;
  public static varendpoint = "streams/tags";

  public static function call(client:Client, query:ReplaceStreamTagsQuery, request:ReplaceStreamTagsRequest):APIResponse<ReplaceStreamTagsResponse> {
    return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
  }
}