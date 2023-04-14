# slarchive

slarchive is a web application for parsing and displaying slack archival json from an exported slack zip file. The backend api parses the file and returns a more friendly json response in the form of a single object.

## Installation - Backend Parsing API

After cloning the repo and navigating to the project directory, it's a typical rails install.

```bash
bundle install
rails server
```

Built with Ruby version 3.1.3
No database needed.

## Usage

| Endpoint            | Description                                         |
| ------------------- | --------------------------------------------------- |
| POST /messages.json | expects params hash `{slack_file: [your_zip_file]}` |

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
