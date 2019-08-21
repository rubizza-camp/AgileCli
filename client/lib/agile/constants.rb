# frozen_string_literal: true

module Agile
  VERSION = "0.0.11"
  GITHUB_URL = %(https://api.github.com/user)
  TERMINAL_STYLE = { border_x: "=", border_i: "x", padding_left: 3 }.freeze
  URL_PATTERN = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$\//
  LOCALHOST_PATTERN = /localhost:\//
end
