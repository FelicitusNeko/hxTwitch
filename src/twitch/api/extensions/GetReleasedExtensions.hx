package twitch.api.extensions;

import haxe.http.HttpMethod;
import twitch.api.APIEndpoint;

typedef GetReleasedExtensionsQuery = {
  var extension_id:String;
  var ?extension_version:String;
}

typedef GetReleasedExtensionsRequest = {
}

typedef GetReleasedExtensionsResponse = Array<{
  var author_name:String;
  var bits_enabled:Bool;
  var can_install:Bool;
  var configuration_location:String;
  var description:String;
  var eula_tos_url:String;
  var has_chat_support:Bool;
  var icon_url:String;
  var icon_urls:Map<String, String>;
  var id:String;
  var name:String;
  var privacy_policy_url:String;
  var request_identity_link:Bool;
  var screenshot_urls:Array<String>;
  var state:String;
  var subscriptions_support_level:String;
  var version:String;
  var viewer_summary:String;
  var views:{
    var ?mobile:{
      var viewer_url:String;
    };
    var ?panel:{
      var viewer_url:String;
      var height:Int;
      var can_link_external_content:Bool;
    };
    var ?video_overlay:{
      var viewer_url:String;
      var can_link_external_content:Bool;
    };
    var ?component:{
      var viewer_url:String;
      var aspect_width:Int;
      var aspect_height:Int;
      var aspect_ratio_x:Int;
      var aspect_ratio_y:Int;
      var autoscale:Bool;
      var scale_pixels:Int;
      var target_height:Int;
      var size:Int;
      var zoom:Bool;
      var zoom_pixels:Int;
      var can_link_external_content:Bool;
    };
  };
  var allowlisted_config_urls:Array<String>;
  var allowlosted_panel_urls:Array<String>;
}>

class GetReleasedExtensions extends APIEndpoint {
  public static varscopeRequired = "";
  public static varoauthRequired = true;
  public static varmethod = HttpMethod.Get;
  public static varendpoint = "extensions/released";

  public static function call(client:Client, query:GetReleasedExtensionsQuery):APIResponse<GetReleasedExtensionsResponse> {
    return APIEndpoint.call(method, endpoint, client, query);
  }
}