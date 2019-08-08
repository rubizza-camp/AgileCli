module Agile
  class CLI < Thor
    desc "values", "Shows core agile values"
    def values
      say File.read("lib/agile/agile_values.txt")
    end
  end
end
