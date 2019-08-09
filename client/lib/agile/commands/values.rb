module Agile
  class CLI < Thor
    desc Rainbow("values").cornflower, Rainbow("Shows core agile values").darkgoldenrod
    def values
      say File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/agile_values.txt")
    end
  end
end
