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
  static var scopeRequired = "";
  static var oauthRequired = true;
  static var method = HttpMethod.Get;
  static var endpoint = "eventsub/subscriptions";

  public static function call(client:Client, query:GetEventSubSubscriptionsQuery):APIResponse<GetEventSubSubscriptionsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}