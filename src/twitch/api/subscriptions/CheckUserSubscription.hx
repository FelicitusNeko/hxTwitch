package twitch.api.subscriptions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CheckUserSubscriptionQuery = {
  var user_id:String;
  var broadcaster_id:String;
}

typedef CheckUserSubscriptionRequest = {
}

typedef CheckUserSubscriptionResponse = Array<{
  var broadcaster_id:String;
  var broadcaster_login:String;
  var broadcaster_name:String;
  var is_gift:Bool;
  var ?gifter_id:String;
  var ?gifter_login:String;
  var ?gifter_name:String;
  var tier:String;
}>

class CheckUserSubscription extends APIEndpoint {
  public static var scopeRequired = "user:read:subscriptions";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "subscriptions/user";

  public static function call(client:Client, query:CheckUserSubscriptionQuery):APIResponse<CheckUserSubscriptionResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}