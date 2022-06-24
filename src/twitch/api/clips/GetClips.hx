package twitch.api.clips;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetClipsQuery = {
  var ?broadcaster_id:String;
  var ?game_id:String;
  var ?id:String;
  var ?after:String;
  var ?before:String;
  var ?ended_at:String;
  var ?first:Int;
  var ?started_at:String;
}

typedef GetClipsRequest = {
}

typedef GetClipsResponse = Array<{
  var id:String;
  var url:String;
  var embed_url:String;
  var broadcaster_id:String;
  var broadcaster_name:String;
  var creator_id:String;
  var creator_name:String;
  var video_id:String;
  var game_id:String;
  var language:String;
  var title:String;
  var view_count:Int;
  var created_at:String;
  var thumbnail_url:String;
  var duration:Float;
}>

class GetClips extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "clips";

  public static function call(client:Client, query:GetClipsQuery):APIResponse<GetClipsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}