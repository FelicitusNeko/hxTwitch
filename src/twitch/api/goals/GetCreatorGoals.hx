package twitch.api.goals;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetCreatorGoalsQuery = {
  var broadcaster_id:String;
}

typedef GetCreatorGoalsRequest = {
}

typedef GetCreatorGoalsResponse = Array<{
  var id:String;
  var broadcaster_id:String;
  var broadcaster_name:String;
  var broadcaster_login:String;
  var type:String;
  var description:String;
  var current_amount:Int;
  var target_amount:Int;
  var created_at:String;
}>

class GetCreatorGoals extends APIEndpoint {
  public static var scopeRequired = "channel:read:goals";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "goals";

  public static function call(client:Client, query:GetCreatorGoalsQuery):APIResponse<GetCreatorGoalsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}