require "thor"
require "rainbow"
require "agile/constants"
require "json"
require "rest-client"
require "terminal-table"
require "highline"
Dir[File.join(__dir__, "agile/commands", "*.rb")].each { |file| require file }

module Agile
  GEM_PATH = `gem which agile`.chomp.chomp("agile.rb")
  if `find "#{GEM_PATH}" -name .config.json`.empty?
    `touch #{GEM_PATH}.config.json`
    File.write("#{GEM_PATH}.config.json", {})
  end

  CONFIG = JSON.parse(File.read("#{GEM_PATH}.config.json"))

  class CLI < Thor
  end
end
