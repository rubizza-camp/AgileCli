module Agile
  class CLI < Thor
    desc Rainbow("principles").cornflower, Rainbow("Shows twelwe agile principles").darkgoldenrod
    def principles
      principl = []
      principl << File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/assets/agile_principles.txt")
      table = Terminal::Table.new headings: ["12 Principles"], rows: [principl], style: TERMINAL_STYLE
      say table
    end
  end
end
