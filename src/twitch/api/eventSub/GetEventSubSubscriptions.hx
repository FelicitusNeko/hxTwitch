package twitch.api.eventSub;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetEventSubSubscriptionsQuery = {
}

typedef GetEventSubSubscriptionsRequest = {
}

typedef GetEventSubSubscriptionsResponse = Array<{
  var id:String;
  var status:String;
  var type:String;
  var version:String;
  var condition:Dynamic;
  var created_at:String;
  var transport:{
    var method:String;
    var callback:String;
  };
  var cost:Int;
}>

class GetEventSubSubscriptions extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "eventsub/subscriptions";

  public static function call(client:Client, query:GetEventSubSubscriptionsQuery):APIResponse<GetEventSubSubscriptionsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}