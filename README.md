# [slarchive](https://slarchive.onrender.com)

slarchive is a web application for parsing and displaying slack archival json from an exported slack zip file. The backend api parses the file and returns a more friendly json response in the form of a single object.

Backend is built using Ruby on Rails.

## Installation - Backend Parsing API

After cloning the repo and navigating to the project directory, it's a typical rails install.

```bash
bundle install
rails server
```

Built with Ruby version 3.1.3
No database needed.

[Front end info can be found here](https://github.com/joeyharbert/slarchive-frontend)

## Usage

| Endpoint            | Description                                         |
| ------------------- | --------------------------------------------------- |
| POST /messages.json | expects params hash `{slack_file: [your_zip_file]}` |

The response is formatted as follows:

```javascript
// All of this info is direct from the slack export, just conglomerated into
// one object instead of a mass of files. As of now, all I have added is a date
// for the messages.
{
   channels: [   //array containing all channel objects
      {
         id: 'stringID',
         name: 'string representation of channel name',
         created: 0 //created at timestamp
         creator: 'string userID of creating user',
         is_archived: false, //boolean value
         members: ['array of userID strings'],
         purpose: {
            creator: 'userID',
            last_set: 0, //timestamp
            value: 'string of channel purpose'
         },
        topic: {
            creator: 'userID',
            last_set: 0, //timestamp
            value: 'string of channel topic'
         }
      }
   ],
   integration_logs: [ //array of integrated slack tools
      {
         app_id: 'appID',
         app_type: 'string app name',
         change_type: 'added' //I'd assume this could say removed, etc?
         date: '1674250535' //timestamp??
         user_id: 'userID',
         user_name: 'actual username'
      }
   ],
   messages: { //this is an object containing all messages separated by channel
      channel_name: [ //this key will be the actual name of the channel as seen in slack
                     //not sure how it will work with space separated names, might get hinky
         {  //this is a channel join object, not all objects look the same
            date: '2023-03-08' //this I added based on json file name in the export
            subtype: 'channel_join',
            text: "<@display_name> has joined the channel",
            ts: '1678295583.868509', //surprisingly not a true timestamp, thanks slack
            type: "message",
            user: "userID",
            user_profile: {
              title: "",
              phone: "",
              skype: "",
              real_name: "First Last",
              real_name_normalized: "First Last",
              display_name: "First Last",
              display_name_normalized: "First Last",
              fields: {},
              status_text: "",
              status_emoji: "",
              status_emoji_display_info: [],
              status_expiration: 0,
              avatar_hash: "97ccafc9cb62",
              image_original: "https://url_to_avatar/image_original.png",
              is_custom_image: true,
              email: "user_email",
              first_name: "first_name",
              last_name: "last_name",
              image_24: "https://url_to_avatar/image_24.png",
              image_32: "https://url_to_avatar/image_32.png",
              image_48: "https://url_to_avatar/image_48.png",
              image_72: "https://url_to_avatar/image_72.png",
              image_192: "https://url_to_avatar/image_192.png",
              image_512: "https://url_to_avatar/image_512.png",
              image_1024: "https://url_to_avatar/image_1024.png",
              status_text_canonical: "",
              team: "teamID"
          }
         },
        { //this is a more normal message type
          client_msg_id: "messageID",
          type: "message",
          text: "actual message text here",
          user: "userID",
          ts: "1678295920.404719", //again not real timestamp, but you can order by this for a correct order
          blocks: [ //for any code blocks, links etc
              {
                  type: "rich_text",
                  block_id: "mGarx",
                  elements: [
                      {
                          type: "rich_text_section",
                          elements: [
                              {
                                  type: "link",
                                  url: "https://whateverlink.com/",
                                  text: "Text for said link"
                              }
                          ]
                      }
                  ]
              }
          ],
          team: "teamID",
          user_team: "teamID",
          source_team: "teamID",
          user_profile: { //for some reason sometimes user_profile is less verbose
              avatar_hash: "97ccafc9cb62",
              image_72: "https://url_to_avatar_72.png",
              first_name: "First",
              real_name: "First Last",
              display_name: "FirstLast",
              team: "teamID",
              name: "username",
              is_restricted: false,
              is_ultra_restricted: false
          },
          attachments: [
              {
                  image_url: "https://url.png", //url for preview beneath message
                  image_width: 1200,
                  image_height: 628,
                  image_bytes: 35203,
                  from_url: "https://url.com", //actual url linked in message
                  service_icon: "https://url.com/favicon.ico",
                  id: 1,
                  original_url: "https://url.com",
                  fallback: "Alt Title",
                  text: "url text",
                  title: "Title of Page",
                  title_link: "https://url.com",
                  service_name: "name from url"
              }
          ],
          date: "2023-03-08" //my added date from filename
        },
        { //this is a message object with images attached
          type: "message",
          text: "",
          files: [
              {
                  id: "imageID",
                  created: 1674770488, //timestamp
                  timestamp: 1674770488, //why do we need it twice? idek
                  name: "IMG_2197.jpg",
                  title: "IMG_2197",
                  mimetype: "image/jpeg",
                  filetype: "jpg",
                  pretty_type: "JPEG",
                  user: "userID",
                  user_team: "teamID",
                  editable: false,
                  size: 1013040,
                  mode: "hosted",
                  is_external: false,
                  external_type: "",
                  is_public: true,
                  public_url_shared: false,
                  display_as_bot: false,
                  username: "",
                  url_private: "https://files.slack.com/...",
                  url_private_download: "https://files.slack.com/...",
                  media_display_type: "unknown",
                  thumb_64: "https://files.slack.com/...",
                  thumb_80: "https://files.slack.com/...",
                  thumb_360: "https://files.slack.com/...",
                  thumb_360_w: 270,
                  thumb_360_h: 360,
                  thumb_480: "https://files.slack.com/...",
                  thumb_480_w: 360,
                  thumb_480_h: 480,
                  thumb_160: "https://files.slack.com/...",
                  thumb_720: "https://files.slack.com/...",
                  thumb_720_w: 540,
                  thumb_720_h: 720,
                  thumb_800: "https://files.slack.com/...",
                  thumb_800_w: 800,
                  thumb_800_h: 1067,
                  thumb_960: "https://files.slack.com/...",
                  thumb_960_w: 720,
                  thumb_960_h: 960,
                  thumb_1024: "https://files.slack.com/...",
                  thumb_1024_w: 768,
                  thumb_1024_h: 1024,
                  original_w: 3024,
                  original_h: 4032,
                  thumb_tiny: "AwAwACSyVNG0nBp554oFSMjK4OOcU5cegpXIzSAimA7ah6gUbE/uikooARnCDk4qH7QC2Aw/OknYHK5HSs0NgUAanmqTksM04MewJrILkjrV+zuWZSrFcjueM0WAn+ej56lDMRkAH3Bo3N/dpAUrhwsbBep71Qq3OMo351TpoGL1NSRxs74X8TUYq1bkAcUxFuGERpgkknnjin7B7/nTQxI+7n3FG4/3D+dIZ//Z",  // ¯\_(ツ)_/¯
                  permalink: "https://workspace.com/image.jpg",
                  permalink_public: "https://slack-files.com/...",
                  is_starred: false,
                  has_rich_preview: false,
                  file_access: "visible"
              }
          ],
          upload: false,
          user: "userID",
          display_as_bot: false,
          ts: "1674770492.886299", //not a timestamp
          client_msg_id: "messageID",
          reactions: [
              {
                  name: "heart",
                  users: [
                      "userID",
                  ],
                  count: 1
              }
          ],
          date: "2023-01-26",
          user_profile: {
              title: "",
              phone: "",
              skype: "",
              real_name: "First LAST",
              real_name_normalized: "First LAST",
              display_name: "",
              display_name_normalized: "",
              fields: {},
              status_text: "",
              status_emoji: "",
              status_emoji_display_info: [],
              status_expiration: 0,
              avatar_hash: "g829341173b5",
              email: "email@email.com",
              first_name: "First",
              last_name: "Last",
              image_24: "https://url.com/image-24.png",
              image_32: "https://url.com/image-32.png",
              image_48: "https://url.com/image-48.png",
              image_72: "https://url.com/image-72.png",
              image_192: "https://url.com/image-192.png",
              image_512: "https://url.com/image-512.png",
              status_text_canonical: "",
              team: "teamID"
          }
        }
    ],
    users: [ //array of user objects
      {
        id: "userID",
        team_id: "teamID",
        name: "username",
        deleted: false,
        color: "e96699", //? maybe this is the color of the avatar person
        real_name: "First Last",
        tz: "America/Chicago",
        tz_label: "Central Daylight Time",
        tz_offset: -18000,
        profile: {
            title: "",
            phone: "",
            skype: "",
            real_name: "First Last",
            real_name_normalized: "First Last",
            display_name: "",
            display_name_normalized: "",
            fields: {},
            status_text: "",
            status_emoji: "",
            status_emoji_display_info: [],
            status_expiration: 0,
            avatar_hash: "b8ed508f301a",
            image_original: "https://url.com/image_original.png",
            is_custom_image: true,
            email: "email@email.com",
            first_name: "First",
            last_name: "Last",
            image_24: "https://url.com/image_24.png",
            image_32: "https://url.com/image_32.png",
            image_48: "https://url.com/image_48.png",
            image_72: "https://url.com/image_72.png",
            image_192: "https://url.com/image_192.png",
            image_512: "https://url.com/image_512.png",
            image_1024: "https://url.com/image_1024.png",
            status_text_canonical: "",
            team: "teamID"
        },
        is_admin: false,
        is_owner: false,
        is_primary_owner: false,
        is_restricted: false,
        is_ultra_restricted: false,
        is_bot: false,
        is_app_user: false,
        updated: 1679930460, //timestamp
        is_email_confirmed: true,
        who_can_share_contact_card: "EVERYONE"
      }
    ]
   }
}
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
