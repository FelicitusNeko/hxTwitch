package twitch.pubsub;

import twitch.Client;

@:noCompletion
abstract class PubSubTopic {
  public static var scope:String;
  public static var topicTemplate:String;

  @:generic
  public static function listen<T>(client:Client, topic:String, callback:T->Void) {
    client.psListen(topic, msg -> (callback(msg.data.message)));
  }
}