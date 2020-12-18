# jinxp

single binary to build a jinx repo

## Installation

```
curl -s https://api.github.com/repos/elanthia-online/jinxp/releases/latest \
  | grep browser_download_url \
  | grep jinxp \
  | cut -d '"' -f 4 \
  | wget -qi -
```

## Usage

```
jinxp --help
```

## Development

clone this repo, make a pr

## Contributing

1. Fork it (<https://github.com/elanthia-online/jinx/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ondreian](https://github.com/ondreian) - creator and maintainer
