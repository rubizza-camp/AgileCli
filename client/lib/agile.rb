require "thor"
require "rainbow"
require "agile/constants"
require "terminal-table"
Dir[File.join(__dir__, "agile/commands", "*.rb")].each { |file| require file }

module Agile
  class CLI < Thor
  end
end
