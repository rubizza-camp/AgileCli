module Agile
  class CLI < Thor
    desc Rainbow("dor").cornflower, Rainbow("Shows you rules of writing items").darkgoldenrod
    def dor
      dor = []
      dor << File.read("#{GEM_PATH}/agile/assets/definition_of_ready.txt")
      say Terminal::Table.new title: "Definition of Ready", rows: [dor], style: TERMINAL_STYLE
    end
  end
end
