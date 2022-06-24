package twitch.api.predictions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetPredictionsQuery = {
  var broadcaster_id:String;
  var ?id:String;
  var ?after:String;
  var ?first:String;
}

typedef GetPredictionsRequest = {
}

typedef GetPredictionsResponse = Array<{
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

class GetPredictions extends APIEndpoint {
  public static varscopeRequired = "channel:read:predictions";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "predictions";

  public static function call(client:Client, query:GetPredictionsQuery):APIResponse<GetPredictionsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}