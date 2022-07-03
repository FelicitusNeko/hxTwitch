package twitch.api.predictions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef EndPredictionQuery = {
}

typedef EndPredictionRequest = {
  var broadcaster_id:String;
  var id:String;
  var status:String;
  var ?winning_outcome_id:String;
}

typedef EndPredictionResponse = Array<{
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

class EndPrediction extends APIEndpoint {
  public static var scopeRequired = "channel:manage:predictions";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Patch;
  public static var endpoint = "predictions";

  public static function call(client:Client, request:EndPredictionRequest):APIResponse<EndPredictionResponse> {
    return APIEndpoint.call(method, endpoint, client, [], request);
  }
}