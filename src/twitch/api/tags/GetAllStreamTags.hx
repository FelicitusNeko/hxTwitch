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
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "tags/streams";

  public static function call(client:Client, query:GetAllStreamTagsQuery):APIResponse<GetAllStreamTagsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}