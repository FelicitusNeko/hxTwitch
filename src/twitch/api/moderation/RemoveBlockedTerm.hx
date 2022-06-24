package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef RemoveBlockedTermQuery = {
  var broadcaster_id:String;
  var moderator_id:String;
  var id:String;
}

typedef RemoveBlockedTermRequest = {
}

typedef RemoveBlockedTermResponse = {}

class RemoveBlockedTerm extends APIEndpoint {
  public static varscopeRequired = "moderator:manage:blocked_terms";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Delete;
  public static varendpoint = "moderation/blocked_terms";

  public static function call(client:Client, query:RemoveBlockedTermQuery):APIResponse<RemoveBlockedTermResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}