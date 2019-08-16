module Agile
  class CLI < Thor
    desc Rainbow("values").cornflower, Rainbow("Shows core agile values").darkgoldenrod
    def values
      values = []
      values << File.read("#{GEM_PATH}/agile/assets/agile_values.txt")
      say Terminal::Table.new title: "Values", rows: [values], style: TERMINAL_STYLE
    end
  end
end
