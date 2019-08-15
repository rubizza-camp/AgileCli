# frozen_string_literal: true

module Agile
  VERSION = "0.0.7"
  GITHUB_URL = %(https://api.github.com/user)
  GEM_PATH = `gem which agile`.chomp.chomp("agile.rb").to_s
end
