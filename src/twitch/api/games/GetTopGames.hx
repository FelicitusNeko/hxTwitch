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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "games/top";

  public static function call(client:Client, query:GetTopGamesQuery):APIResponse<GetTopGamesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}