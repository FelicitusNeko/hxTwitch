package twitch.api.teams;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetChannelTeamsQuery = {
  var broadcaster_id:String;
}

typedef GetChannelTeamsRequest = {
}

typedef GetChannelTeamsResponse = Array<{
  var broadcaster_id:String;
  var broadcaster_login:String;
  var broadcaster_name:String;
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

class GetChannelTeams extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "teams/channel";

  public static function call(client:Client, query:GetChannelTeamsQuery):APIResponse<GetChannelTeamsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}