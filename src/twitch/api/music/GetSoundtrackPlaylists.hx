package twitch.api.music;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetSoundtrackPlaylistsQuery = {
}

typedef GetSoundtrackPlaylistsRequest = {
}

typedef GetSoundtrackPlaylistsResponse = Array<{
  var id:String;
  var title:String;
  var description:String;
  var image_url:String;
}>

class GetSoundtrackPlaylists extends APIEndpoint {
  public static var scopeRequired = "";
  public static var oauthRequired = true;
  public static var method = HttpMethod.Get;
  public static var endpoint = "soundtrack/playlists";

  public static function call(client:Client):APIResponse<GetSoundtrackPlaylistsResponse> {
    return APIEndpoint.call(method, endpoint, client);
  }
}