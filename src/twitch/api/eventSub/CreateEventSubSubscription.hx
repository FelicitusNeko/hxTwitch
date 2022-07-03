package twitch.api.eventSub;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CreateEventSubSubscriptionQuery = {
}

typedef CreateEventSubSubscriptionRequest = {
  var type:String;
  var version:String;
  var condition:Dynamic;
  var transport:{
    var method:String;
    var callback:String;
    var secret:String;
  };
}

typedef CreateEventSubSubscriptionResponse = Array<{
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

class CreateEventSubSubscription extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Post;
  public static var endpoint = "eventsub/subscriptions";

  public static function call(client:Client, request:CreateEventSubSubscriptionRequest):APIResponse<CreateEventSubSubscriptionResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}