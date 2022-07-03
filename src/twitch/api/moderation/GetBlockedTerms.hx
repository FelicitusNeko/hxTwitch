package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetBlockedTermsQuery = {
  var broadcaster_id:String;
  var moderator_id:String;
  var ?after:String;
  var ?first:String;
}

typedef GetBlockedTermsRequest = {
}

typedef GetBlockedTermsResponse = Array<{
  var broadcaster_id:String;
  var moderator_id:String;
  var id:String;
  var text:String;
  var created_at:String;
  var updated_at:String;
  var ?expires_at:String;
}>

class GetBlockedTerms extends APIEndpoint {
  public static var scopeRequired = "moderator:read:blocked_terms";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "moderation/blocked_terms";

  public static function call(client:Client, query:GetBlockedTermsQuery):APIResponse<GetBlockedTermsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}