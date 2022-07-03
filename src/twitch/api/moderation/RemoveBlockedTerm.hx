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
  public static var scopeRequired = "moderator:manage:blocked_terms";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Delete;
  public static var endpoint = "moderation/blocked_terms";

  public static function call(client:Client, query:RemoveBlockedTermQuery):APIResponse<RemoveBlockedTermResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}