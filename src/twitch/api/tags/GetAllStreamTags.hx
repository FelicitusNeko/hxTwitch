package twitch.api.tags;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetAllStreamTagsQuery = {
  var ?tag_id:String;
  var ?first:Int;
  var ?after:String;
}

typedef GetAllStreamTagsRequest = {
}

typedef GetAllStreamTagsResponse = Array<{
  var tag_id:String;
  var is_auto:Bool;
  var localization_names:Map<String, String>;
  var localization_descriptions:Map<String, String>;
}>

class GetAllStreamTags extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "tags/streams";

  public static function call(client:Client, query:GetAllStreamTagsQuery):APIResponse<GetAllStreamTagsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}