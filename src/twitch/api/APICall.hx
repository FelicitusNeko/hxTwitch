package twitch.api;

import haxe.http.HttpMethod;
import haxe.Json;

@:generic
typedef APIResponse<R> = {
	var code:Int;
	var ?data:R;
	var ?date_range:{
		var started_at:String;
		var ended_at:String;
	};
	var ?total:Int;
	var ?total_cost:Int;
	var ?max_total_cost:Int;
	var ?pagination:{
		var cursor:String;
	};
	var ?template:String;
}

@:abstract
@:noCompletion
abstract class APICall {
	public static var scopeRequired:Null<String>;
	public static var oauthRequired:Bool;
	public static var method:HttpMethod;
	public static var endpoint:String;

	@:generic
	public static function call<Q:Map<String, Dynamic>, B, R>(client:Client, ?query:Q, ?data:B):APIResponse<R> {
		var retval:APIResponse<R> = {
			code: 0
		};

    client.call(method, endpoint, query, data != null ? Json.stringify(data) : null);

		return retval;
	}
}
