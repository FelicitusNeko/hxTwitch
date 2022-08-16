package twitch.api;

#if macro
import sys.io.File;
import haxe.io.Path;
import haxe.macro.Expr;
import haxe.macro.Context;

using StringTools;

class APIBuilder {
	/** String values that represent a `true` boolean state. **/
	public static var truthy = ["1", "true", "on", "yes"];

	/** String values that represent a `false` boolean state. **/
	public static var falsy = ["0", "false", "off", "no"];

	/**
		Builds a set of API functions.
		@param collection The collection to load from the definition file.
		@return The array of fields to replace those in the target class.
	**/
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
		var root = Xml.parse(File.getContent(defsFile)).firstElement();
		var collections = root.elementsNamed("collection");
		var def:Xml = null;
		var endpointCount = 0;

		for (node in collections)
			if (node.get("name") == collection) {
				def = node;
				break;
			}

		var epList:Array<String> = [];
		if (def != null)
			for (endpoint in def.elementsNamed("endpoint")) {
				endpointCount++;
				var epName = endpoint.get("name");
				if (epName == null) {
					Context.warning('Unnamed endpoint in collection $collection', Context.currentPos());
					continue;
				}
				if (epList.contains(epName)) {
					Context.warning('Duplicate definition of $epName in collection $collection', Context.currentPos());
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
					Context.error('$collection.$epName has no API path specified', Context.currentPos());

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
										type: buildAnonymous(root, node)
									});
								case "response":
                  // This is pretty much 100% here for DeleteVideos, which not only doesn't return 204, but returns an array of strings without any structure
									var rkind = (node.get("type") == "string") ? (macro:Array<String>) : buildAnonymous(root, node,
										!falsy.contains(node.get("array")));
									funcdef.ret = TPath({
										name: "APIResponse",
										params: [TPType(rkind)],
										pack: [],
									});
								case "nullresponse":
									funcdef.ret = TPath({name: "APIResponse", params: [TPType(macro:Void)], pack: []});
								default:
							}
						case PCData:
							if (node.nodeValue != null) {
								if (func.doc == null)
									func.doc = "";
								func.doc += node.nodeValue.trim();
							}
						default:
					}

				if (funcdef.ret == null) {
					// Delete-method endpoints are likely to return 204 No Content; allow this implicitly
					if (method == "Delete")
						funcdef.ret = TPath({name: "APIResponse", params: [TPType(macro:Void)], pack: []});
					// Anything else must specify explicitly with <nullresponse /> or else it's an error
					else
						Context.error('No return type for endpoint $collection.$endpoint', Context.currentPos());
				}

				if (hasBody) {
					if (hasQuery)
						funcdef.expr = macro {
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client, query, request);
						}
					else
						funcdef.expr = macro {
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client, null, request);
						}
				} else {
					if (hasQuery)
						funcdef.expr = macro {
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client, query);
						}
					else
						funcdef.expr = macro {
							return APIEndpoint.call(HttpMethod.$method, $v{path}, client);
						}
				}

				fields.push(func);
			}

		#if debug
		trace('Populated collection $collection with $endpointCount endpoint(s)');
		#end
		return fields;
	}

	/**
		Builds an anonymous structure.
		@param node The XML node on which to base the construction.
		@param responseArray Whether the result should be enclosed in an `Array`, which is the case for most responses.
		@return The anonymous structure. If `responseArray` is true, it will be contained in an `Array`.
	**/
	public static function buildAnonymous(root:Xml, node:Xml, responseArray = false) {
		var retval:Array<Field> = [];
		var commonRef = node.get("commonref");
		var parent = node.parent;
		while (!["endpoint", "commonobject"].contains(parent.nodeName))
			parent = parent.parent;

		if (commonRef != null) {
			var found = false;
			for (commonobj in root.elementsNamed("commonobject"))
				if (commonobj.get("name") == commonRef) {
					node = commonobj;
					found = true;
					break;
				}
			if (!found)
				Context.error('Reference to undefined common object $commonRef in ${parent.nodeName} ${parent.get("name")}', Context.currentPos());
		}

		for (param in node.elementsNamed("param")) {
			var name = param.get("name");
			if (name == null)
				Context.error('Missing parameter name in ${parent.nodeName} ${parent.get("name")}', Context.currentPos());
			else if (!~/[a-zA-Z_][a-zA-Z0-9_]+/.match(name))
				Context.error('Invalid parameter name $name in ${parent.nodeName} ${parent.get("name")}', Context.currentPos());

			var optional = truthy.contains(param.get("optional"));
			var kind = switch (param.get("type")) {
				case "str" | "string" | null: (macro:String);
				case "int" | "integer": (macro:Int);
				case "float" | "decimal": (macro:Float);
				case "bool" | "boolean": (macro:Bool);
				case "obj" | "object": (buildAnonymous(root, param));
				// "map" would generally only be used if:
				// 1) keys may start with digits or contain illegal characters for variable names
				// 2) key names are not fixed and may vary
				case "map": (macro:DynamicAccess<String>);
				case x: Context.error('Unknown type $x in ${parent.nodeName} ${parent.get("name")}', Context.currentPos());
			};

			if (truthy.contains(param.get("array")))
				kind = TPath({name: "Array", params: [TPType(kind)], pack: []});

			var field:Field = {
				name: param.get("name"),
				kind: FVar(kind),
				pos: Context.currentPos(),
				meta: optional ? [{name: ":optional", pos: Context.currentPos()}] : null
			}

			if (truthy.contains(param.get("deprecated"))) {
				if (field.meta == null)
					field.meta = [];
				field.meta.push({name: "deprecated", pos: Context.currentPos()});
			}

			for (member in param)
				if (member.nodeType == PCData && member.nodeValue != null) {
					if (field.doc == null)
						field.doc = "";
					field.doc += member.nodeValue.trim();
				}

			retval.push(field);
		}
		return responseArray ? TPath({name: "Array", params: [TPType(TAnonymous(retval))], pack: []}) : TAnonymous(retval);
	}
}
#end