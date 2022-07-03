package twitch.api.games;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetGamesQuery = {
  var ?id:String;
  var ?name:String;
}

typedef GetGamesRequest = {
}

typedef GetGamesResponse = Array<{
  var id:String;
  var name:String;
  var box_art_url:String;
}>

class GetGames extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "games";

  public static function call(client:Client, query:GetGamesQuery):APIResponse<GetGamesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}