package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UnblockUserQuery = {
  var target_user_id:String;
}

typedef UnblockUserRequest = {
}

typedef UnblockUserResponse = {}

class UnblockUser extends APIEndpoint {
  public static var scopeRequired = "user:manage:blocked_users";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Delete;
  public static var endpoint = "users/blocks";

  public static function call(client:Client, query:UnblockUserQuery):APIResponse<UnblockUserResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}