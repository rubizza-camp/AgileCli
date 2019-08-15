module Agile
  class CLI < Thor
    desc Rainbow("values").cornflower, Rainbow("Shows core agile values").darkgoldenrod
    def values
      values = []
      values << File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/assets/agile_values.txt")
      say Terminal::Table.new title: "Values", rows: [values], style: TERMINAL_STYLE
    end
  end
end
