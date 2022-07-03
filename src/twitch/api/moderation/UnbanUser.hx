package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef UnbanUserQuery = {
  var broadcaster_id:String;
  var moderator_id:String;
  var user_id:String;
}

typedef UnbanUserRequest = {
}

typedef UnbanUserResponse = {}

class UnbanUser extends APIEndpoint {
  public static var scopeRequired = "moderator:manage:banned_users";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Delete;
  public static var endpoint = "moderation/bans";

  public static function call(client:Client, query:UnbanUserQuery):APIResponse<UnbanUserResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}