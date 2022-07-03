package twitch.api.subscriptions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetBroadcasterSubscriptionsQuery = {
  var broadcaster_id:String;
  var ?user_id:String;
  var ?first:Int;
  var ?after:String;
}

typedef GetBroadcasterSubscriptionsRequest = {
}

typedef GetBroadcasterSubscriptionsResponse = Array<{
  var broadcaster_id:String;
  var broadcaster_login:String;
  var broadcaster_name:String;
  var gifter_id:String;
  var gifter_login:String;
  var gifter_name:String;
  var is_gift:Bool;
  var tier:String;
  var plan_name:String;
  var user_id:String;
  var user_login:String;
  var user_name:String;
}>

class GetBroadcasterSubscriptions extends APIEndpoint {
  public static var scopeRequired = "channel:read:subscriptions";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "subscriptions";

  public static function call(client:Client, query:GetBroadcasterSubscriptionsQuery):APIResponse<GetBroadcasterSubscriptionsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}