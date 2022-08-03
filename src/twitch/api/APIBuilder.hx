package twitch.api;

import sys.io.File;
import haxe.http.HttpMethod;
import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.Context;
import twitch.api.APIEndpoint;

using StringTools;

class APIBuilder {
	public static var truthy = ["1", "true", "on", "yes"];

	public static macro function build(collection:String):Array<Field> {
		var fields = Context.getBuildFields();

		// for (field in fields)
		// 	switch (field.kind) {
		// 		case FFun(f):
		// 			trace("name: " + field.name);
		// 			trace("args:");
		//       for (arg in f.args) trace(arg);
		// 			trace("expr: " + f.expr);
		// 			trace("params: " + f.params);
		//       //trace("ret: " + f.ret);
		//       trace("ret:");
		//       switch (f.ret) {
		//         case TPath(p):
		//           for (param in p.params) switch (param) {
		//             case TPType(t):
		//               switch (t) {
		//                 case TAnonymous(fields):
		//                   trace(fields);
		//                 default:
		//               }
		//             default:
		//               trace(param);
		//           }
		//           //trace("ret params: " + p.params);
		//         default:
		//       }
		// 		default:
		// 	}

		var defsFile = Path.join([Path.directory(Context.getPosInfos(Context.currentPos()).file), "Definition.xml"]);
		var collections = Xml.parse(File.getContent(defsFile)).firstElement().elementsNamed("collection");
		var def:Xml = null;
		for (node in collections)
			if (node.get("name") == collection) {
				def = node;
				break;
			}

		var epList:Array<String> = [];
		if (def != null)
			for (endpoint in def.elementsNamed("endpoint")) {
				var epName = endpoint.get("name");
				if (epName == null) {
					Context.warning("Unnamed endpoint in collection " + def.get("name"), Context.currentPos());
					continue;
				}
				if (epList.contains(epName)) {
					Context.warning("Duplicate definition of " + epName + " in collection " + def.get("name"), Context.currentPos());
					continue;
				}
				epList.push(epName);

				var args:Array<FunctionArg> = [
					{
						name: "client",
						type: macro:(twitch.Client)
					}
				];
				var funcdef:Function = {
					args: args
				}
				var func:Field = {
					name: epName,
					access: [APublic, AStatic],
					kind: FFun(funcdef),
					pos: Context.currentPos()
				};
				var method = endpoint.get("method");
				if (method == null)
					method = "Get";
				var path = endpoint.get("path");
				if (path == null)
					Context.error(def.get("name") + "." + endpoint.get("name") + " has no API path specified", Context.currentPos());

				var hasQuery = false, hasBody = false;

				for (node in endpoint)
					switch (node.nodeType) {
						case Element:
							switch (node.nodeName) {
								case x = "query" | "request":
									if (x == "query")
										hasQuery = true;
									else
										hasBody = true;

									args.push({
										name: x,
										type: buildAnonymous(node)
									});
								case "response":
									funcdef.ret = TPath({name: "APIResponse", params: [TPType(buildAnonymous(node, true))], pack: []});
								default:
							}
						case PCData:
							if (node.nodeValue != null) {
								if (func.doc == null)
									func.doc = "";
								func.doc += node.nodeValue;
							}
						default:
					}

				if (hasBody) {
					if (hasQuery)
						funcdef.expr = macro {
							trace("Calling endpoint with query and request");
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client, cast(query, Map<String, Dynamic>), request);
						}
					else
						funcdef.expr = macro {
							trace("Calling endpoint with request only");
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client, [], request);
						}
				} else {
					if (hasQuery)
						funcdef.expr = macro {
							trace("Calling endpoint with query only");
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client, cast(query, Map<String, Dynamic>));
						}
					else
						funcdef.expr = macro {
							trace("Calling endpoint with no data");
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client);
						}
				}

				fields.push(func);
			}

		return fields;
	}

	public static function buildAnonymous(node:Xml, forRetval = true) {
		var retval:Array<Field> = [];
		for (param in node)
			if (param.nodeType == Element) {
				var optional = truthy.contains(param.get("optional"));
				var field:Field = {
					name: param.get("name"),
					kind: switch (param.get("type")) {
						case "string": FVar(optional ? (forRetval ? (macro:Null<String>) : (macro:?String)) : macro:String);
						case "int": FVar(optional ? (macro:?Int) : macro:Int);
						case "bool": FVar(optional ? (macro:?Bool) : macro:Bool);
						case "object": FVar(buildAnonymous(param));
						case x: Context.error("Unknown type " + x, Context.currentPos());
					},
					pos: Context.currentPos()
				}

				for (member in param)
					if (member.nodeType == PCData && member.nodeValue != null) {
						if (field.pos == null)
							field.doc = "";
						field.doc += member.nodeValue.trim();
					}

				retval.push(field);
			}
		return TAnonymous(retval);
	}
}
