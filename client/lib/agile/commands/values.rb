module Agile
  class CLI < Thor
    desc Rainbow("values").cornflower, Rainbow("Shows core agile values").darkgoldenrod
    def values
      say File.read("lib/agile/agile_values.txt")
    end
  end
end
