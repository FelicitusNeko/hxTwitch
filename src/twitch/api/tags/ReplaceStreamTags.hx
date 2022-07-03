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
  public static var scopeRequired = "channel:manage:broadcast";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Put;
  public static var endpoint = "streams/tags";

  public static function call(client:Client, query:ReplaceStreamTagsQuery, request:ReplaceStreamTagsRequest):APIResponse<ReplaceStreamTagsResponse> {
    return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
  }
}