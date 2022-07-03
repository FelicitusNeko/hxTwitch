package twitch.api.teams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetTeamsQuery = {
  var ?name:String;
  var ?id:String;
}

typedef GetTeamsRequest = {
}

typedef GetTeamsResponse = Array<{
  var users:Array<{
    var user_id:String;
    var user_login:String;
    var user_name:String;
  }>;
  var ?background_image_url:String;
  var ?banner:String;
  var created_at:String;
  var updated_at:String;
  var info:String;
  var thumbnail_url:String;
  var team_name:String;
  var team_display_name:String;
  var id:String;
}>

class GetTeams extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "teams";

  public static function call(client:Client, query:GetTeamsQuery):APIResponse<GetTeamsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}