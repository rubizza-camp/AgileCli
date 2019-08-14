module Agile
  class CLI < Thor
    desc Rainbow("manifest").cornflower, Rainbow("Shows manifest").darkgoldenrod
    def dor
      say File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/assets/manifest.txt")
    end
  end
end
