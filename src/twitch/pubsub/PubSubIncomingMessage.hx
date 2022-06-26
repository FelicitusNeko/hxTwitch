package twitch.pubsub;

typedef PubSubIncomingMessage = {
  var type:String;
  var ?nonce:String;
  var ?error:String;
  var ?data:{
    var topic:String;
    var message:Dynamic;
  };
}