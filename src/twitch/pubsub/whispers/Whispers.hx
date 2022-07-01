package twitch.pubsub.whispers;

import haxe.Template;
import twitch.Client;
import twitch.pubsub.PubSubTopic;

typedef WhispersMessage = {
  var type:String;
  var data:{
    var id:String;
  };
  var thread_id:String;
  var body:String;
  var sent_ts:Int;
  var from_id:Int;
  var tags:{
    var login:String;
    var display_name:String;
    var color:String;
    var emotes:Array<Dynamic>; // TODO: figure out what's supposed to be in here
    var badges:Array<{
      var id:String;
      var version:String;
    }>;
  }
  var recipient:{
    var id:Int;
    var username:String;
    var display_name:String;
    var color:String;
    var badges:Array<{
      var id:String;
      var version:String;
    }>;
  };
  var nonce:String;
}

/** Anyone whispers the specified user. **/
class Whispers extends PubSubTopic {
  public static var scope = "whispers:read";
  public static var topicTemplate = "whispers.::userId::";

  public static function listen(client:Client, callback:WhispersMessage->Void, userId:String) {
    PubSubTopic.listen(client, new Template(topicTemplate).execute({userId: userId}), callback);
  }

  public static function unlisten(client:Client, userId:String) {
    client.psUnlisten(new Template(topicTemplate).execute({userId: userId}));
  }
}