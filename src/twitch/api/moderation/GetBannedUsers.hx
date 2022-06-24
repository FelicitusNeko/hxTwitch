package twitch.api.moderation;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetBannedUsersQuery = {
  var broadcaster_id:String;
  var ?user_id:String;
  var ?first:String;
  var ?after:String;
  var ?before:String;
}

typedef GetBannedUsersRequest = {
}

typedef GetBannedUsersResponse = Array<{
  var user_id:String;
  var user_login:String;
  var user_name:String;
  var expires_at:String;
  var created_at:String;
  var reason:String;
  var moderator_id:String;
  var moderator_login:String;
  var moderator_name:String;
}>

class GetBannedUsers extends APIEndpoint {
  public static varscopeRequired = "moderation:read";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "moderation/banned";

  public static function call(client:Client, query:GetBannedUsersQuery):APIResponse<GetBannedUsersResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}