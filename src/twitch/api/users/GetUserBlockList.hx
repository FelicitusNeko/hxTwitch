package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetUserBlockListQuery = {
  var broadcaster_id:String;
}

typedef GetUserBlockListRequest = {
}

typedef GetUserBlockListResponse = Array<{
  var user_id:String;
  var user_login:String;
  var display_name:String;
}>

class GetUserBlockList extends APIEndpoint {
  public static var scopeRequired = "user:read:blocked_users";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "users/blocks";

  public static function call(client:Client, query:GetUserBlockListQuery):APIResponse<GetUserBlockListResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}