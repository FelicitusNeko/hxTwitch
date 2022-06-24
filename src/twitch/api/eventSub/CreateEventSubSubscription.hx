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
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "eventsub/subscriptions";

  public static function call(client:Client, request:CreateEventSubSubscriptionRequest):APIResponse<CreateEventSubSubscriptionResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}