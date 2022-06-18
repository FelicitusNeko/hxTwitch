package twitch;

import haxe.Exception;

class APIException extends Exception {
  public var code(default, null):Int = -1;
  public var data(default, null):Dynamic = null;

  public function new(message:String, ?code:Int, ?data:Dynamic, ?previous:Exception, ?native:Any) {
    super(message, previous, native);
    if (code != null) this.code = code;
    this.data = data;
  }
}