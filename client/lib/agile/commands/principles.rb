module Agile
  class CLI < Thor
    desc Rainbow("principles").cornflower, Rainbow("Shows twelwe agile principles").darkgoldenrod
    def principles
      say File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/agile_principles.txt")
    end
  end
end
