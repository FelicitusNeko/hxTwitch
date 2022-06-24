package twitch.api.predictions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef CreatePredictionQuery = {
}

typedef CreatePredictionRequest = {
  var broadcaster_id:String;
  var title:String;
  var outcomes:Array<{
    var title:String;
  }>;
  var prediction_window:Int;
}

typedef CreatePredictionResponse = Array<{
  var id:String;
  var broadcaster_id:String;
  var broadcaster_login:String;
  var broadcaster_name:String;
  var title:String;
  var ?winning_outcome_id:String;
  var outcomes:Array<{
    var id:String;
    var title:String;
    var users:Int;
    var channel_points:Int;
    var ?top_predictors:Array<{
      var id:String;
      var name:String;
      var login:String;
      var channel_points_used:Int;
      var channel_points_won:Int;
    }>;
    var color:String;
  }>;
  var prediction_window:Int;
  var status:String;
  var created_at:String;
  var ?ended_at:String;
  var ?locked_at:String;
}>

class CreatePrediction extends APIEndpoint {
  public static varscopeRequired = "channel:manage:predictions";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Post;
  public static varendpoint = "predictions";

  public static function call(client:Client, request:CreatePredictionRequest):APIResponse<CreatePredictionResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}