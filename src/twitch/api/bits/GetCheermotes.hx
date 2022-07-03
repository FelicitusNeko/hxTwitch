package twitch.api.bits;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetCheermotesQuery = {
  var ?broadcaster_id:String;
}

typedef GetCheermotesRequest = {
}

typedef GetCheermotesResponse = Array<{
  var prefix:String;
  var tiers:Array<{
    var min_bits:Int;
    var id:String;
    var color:String;
    var images:{
      // HACK: These collections contain the word "static" and entries that start with a number,
      //       so it's not possible to have the full structure defined here :/
      var dark:Map<String, Map<String, String>>;
      var light:Map<String, Map<String, String>>;
    }
    var can_cheer:Bool;
    var show_in_bits_card:Bool;
  }>;
  var type:String;
  var order:Int;
  var last_updated:String;
  var is_charitable:Bool;
}>

class GetCheermotes extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "bits/cheermotes";

  public static function call(client:Client, query:GetCheermotesQuery):APIResponse<GetCheermotesResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}