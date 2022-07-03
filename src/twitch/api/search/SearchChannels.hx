package twitch.api.search;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef SearchChannelsQuery = {
  var query:String;
  var ?first:Int;
  var ?after:String;
  var ?live_only:Bool;
}

typedef SearchChannelsRequest = {
}

typedef SearchChannelsResponse = Array<{
  var broadcaster_language:String;
  var broadcaster_login:String;
  var display_name:String;
  var game_id:String;
  var game_name:String;
  var id:String;
  var is_live:Bool;
  var tags_ids:Array<String>;
  var thumbnail_art:String;
  var title:String;
  var started_at:String;
}>

class SearchChannels extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "search/channels";

  public static function call(client:Client, query:SearchChannelsQuery):APIResponse<SearchChannelsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}