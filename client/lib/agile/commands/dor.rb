module Agile
  class CLI < Thor
    desc Rainbow("dor").cornflower, Rainbow("Shows you rules of writing items").darkgoldenrod
    def dor
      say File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/assets/definition_of_ready.txt")
    end
  end
end
