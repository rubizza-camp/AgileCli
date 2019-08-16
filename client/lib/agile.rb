require "thor"
require "rainbow"
require "agile/constants"
require "json"
require "rest-client"
require "terminal-table"
Dir[File.join(__dir__, "agile/commands", "*.rb")].each { |file| require file }

module Agile
  GEM_PATH = `gem which agile`.chomp.chomp("agile.rb")
  CONFIG = JSON.parse(File.read("#{GEM_PATH}.config.json"))

  class CLI < Thor
  end
end
