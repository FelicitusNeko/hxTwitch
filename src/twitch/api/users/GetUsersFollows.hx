package twitch.api.users;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetUsersFollowsQuery = {
  var ?from_id:String;
  var ?to_id:String;
  var ?first:Int;
  var ?after:String;
}

typedef GetUsersFollowsRequest = {
}

typedef GetUsersFollowsResponse = Array<{
  var from_id:String;
  var from_login:String;
  var from_name:String;
  var to_id:String;
  var to_login:String;
  var to_name:String;
  var followed_at:String;
}>

class GetUsersFollows extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "users/follows";

  public static function call(client:Client, query:GetUsersFollowsQuery):APIResponse<GetUsersFollowsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}