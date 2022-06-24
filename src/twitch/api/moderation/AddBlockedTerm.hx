package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef AddBlockedTermQuery = {
  var broadcaster_id:String;
  var moderator_id:String;
}

typedef AddBlockedTermRequest = {
  var text:String;
}

typedef AddBlockedTermResponse = Array<{
  var broadcaster_id:String;
  var moderator_id:String;
  var id:String;
  var text:String;
  var created_at:String;
  var updated_at:String;
  var ?expires_at:String;
}>

class AddBlockedTerm extends APIEndpoint {
  public static varscopeRequired = "moderator:manage:blocked_terms";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "moderation/blocked_terms";

  public static function call(client:Client, query:AddBlockedTermQuery, request:AddBlockedTermRequest):APIResponse<AddBlockedTermResponse> {
    return APIEndpoint.call(method, endpoint, client, cast(query, Map<String, Dynamic>), request);
  }
}