package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef BlockUserQuery = {
  var target_user_id:String;
  var ?source_context:String;
  var ?reason:String;
}

typedef BlockUserRequest = {
}

typedef BlockUserResponse = {}

class BlockUser extends APIEndpoint {
  public static var scopeRequired = "user:manage:blocked_users";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Put;
  public static var endpoint = "users/blocks";

  public static function call(client:Client, query:BlockUserQuery):APIResponse<BlockUserResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}