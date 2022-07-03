package twitch.api.music;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetSoundtrackCurrentTrackQuery = {
  var broadcaster_id:String;
}

typedef GetSoundtrackCurrentTrackRequest = {
}

typedef GetSoundtrackCurrentTrackResponse = Array<{
  var track:{
    var artists:Array<{
      var id:String;
      var name:String;
      var creator_channel_id:String;
    }>;
    var id:String;
    var duration:Int;
    var title:String;
    var album:{
      var id:String;
      var name:String;
      var image_url:String;
    };
  };
  var source:{
    var id:String;
    var content_type:String;
    var title:String;
    var image_url:String;
    var soundtrack_url:String;
    var spotify_url:String;
  };
}>

class GetSoundtrackCurrentTrack extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "soundtrack/current_track";

  public static function call(client:Client, query:GetSoundtrackCurrentTrackQuery):APIResponse<GetSoundtrackCurrentTrackResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}