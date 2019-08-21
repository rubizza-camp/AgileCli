# rubocop:disable Style/RegexpLiteral

module Agile
  VERSION = "0.0.11"
  GITHUB_URL = %(https://github.com/login)
  TERMINAL_STYLE = { border_x: "=", border_i: "x", padding_left: 3 }.freeze
  CLIENT_ID = "8bf42da7e4f9032ac5d8"
  CLIENT_SECRET = "cfef987b3839a1a846ba3f0707aa036240d2d625"
  URL_PATTERN = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$}/
  LOCALHOST_PATTERN = /localhost:/
end
# rubocop:enable Style/RegexpLiteral
