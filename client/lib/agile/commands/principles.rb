module Agile
  class CLI < Thor
    desc Rainbow("principles").cornflower, Rainbow("Shows twelwe agile principles").darkgoldenrod
    def principles
      principl = []
      principl << File.read("#{GEM_PATH}/agile/assets/agile_principles.txt")
      say Terminal::Table.new title: "Agile principles", rows: [principl], style: TERMINAL_STYLE
    end
  end
end
