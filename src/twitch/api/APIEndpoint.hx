package twitch.api;

import haxe.Exception;
import haxe.http.HttpMethod;
import haxe.Json;

@:generic
typedef APIResponse<R> = {
	var ?code:Int;
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
	var ?points:Int;
}

@:abstract
@:noCompletion
abstract class APIEndpoint {
	public static var scopeRequired:Null<String>;
	public static var oauthRequired:Bool;
	public static var method:HttpMethod;
	public static var endpoint:String;

	@:generic
	public static function call<R>(method:HttpMethod, endpoint:String, client:Client, ?query:Dynamic, ?data:Dynamic):APIResponse<R> {
		if (query != null && !Reflect.isObject(query)) throw new Exception("Query data is not an object");

		var queryMap:Map<String, Dynamic> = query == null ? null : [];
		if (query != null)
			for (key in Reflect.fields(query))
				if (Reflect.field(query, key) != null)
					queryMap.set(key, Reflect.field(query, key));
		
		var apidata = client.call(method, endpoint, queryMap, data != null ? Json.stringify(data) : null);

		var retval:APIResponse<R> = {};

		if (apidata.code != 204 && apidata.text != null) retval = Json.parse(apidata.text);
		retval.code = apidata.code;

		return retval;
	}
}
