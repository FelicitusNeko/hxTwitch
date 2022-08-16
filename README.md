# hxTwitch

This project has as a goal to cover all of the bases as far as interaction with Twitch:

- [X] [API](https://dev.twitch.tv/docs/api)
  - Currently, Extensions endpoints are not implemented, due to most of them requiring JWTs for authentication.
  - Additionally, retrieving a channel's iCalendar-formatted schedule is not implemented, due to the response not being JSON-based.
- [X] [IRC-based chat](https://dev.twitch.tv/docs/irc) (over websocket)
  - Authentication has not been tested. Anonymous login and message processing are working.
- [ ] [PubSub](https://dev.twitch.tv/docs/pubsub)
  - This is more or less written, but has not been tested at all.
- [ ] [EventSub](https://dev.twitch.tv/docs/eventsub) (via server relay, over websocket)
  - Not at all implemented at the moment.

Additionally, the library can be used to generate an app access token to access certain API calls that do not need user authentication, and can also generate an OAuth login URL, to generate a token to gain access to all platform features.

## Example Usage

### Authenticated API call

```haxe
import twitch.Client;
using twitch.api.Users;

[...]

var client = new Client(clientId, clientSecret);
client._oauthKey = "abcd1234";
// Retrieve the current logged-in user's data
var me = client.GetUsers({});
```

### Connecting to chat anonymously

```haxe
import twitch.Client;

[...]

var client = new Client(clientId, clientSecret);
client.onChatConnect = () -> client.chatJoin("#mychannel");
client.onChatDisconnect = () -> { /* deinit here */ };
client.irc_onMessage = (msg) -> switch (msg) {
  case PrivMsg(data):
    trace('[${data.destination}] <${data.tags.display_name} ${data.user}> ${data.params}');
  default:
    trace(msg);
}
client.chatConnect();
```