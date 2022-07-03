package twitch.api.games;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetTopGamesQuery = {
  var ?after:String;
  var ?before:String;
  var ?first:Int;
}

typedef GetTopGamesRequest = {
}

typedef GetTopGamesResponse = Array<{
  var id:String;
  var name:String;
  var box_art_url:String;
}>

class GetTopGames extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "games/top";

  public static function call(client:Client, query:GetTopGamesQuery):APIResponse<GetTopGamesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}