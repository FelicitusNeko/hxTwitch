package twitch.chat;

/** The type of chat message to send. **/
enum ChatSayType {
  /** Sends a standard message. **/
  Say;
  /** Performs a /me action. **/
  Action;
  /** Broadcasts a standard announcement. Recipient must be a channel. User must be a moderator in that channel. Colored announcements must be done via API. **/
  Announce;
}