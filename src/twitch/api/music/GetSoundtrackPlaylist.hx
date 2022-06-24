package twitch.api.music;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetSoundtrackPlaylistQuery = {
  var id:String;
}

typedef GetSoundtrackPlaylistRequest = {
}

typedef GetSoundtrackPlaylistResponse = Array<{
  var id:String;
  var title:String;
  var description:String;
  var image_url:String;
  var tracks:Array<{
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
  }>;
}>

class GetSoundtrackPlaylist extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "soundtrack/playlist";

  public static function call(client:Client, query:GetSoundtrackPlaylistQuery):APIResponse<GetSoundtrackPlaylistResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}