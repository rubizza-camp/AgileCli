module Agile
  class CLI < Thor
    desc Rainbow("principles").cornflower, Rainbow("Shows twelwe agile principles").darkgoldenrod
    def principles
      say File.read("lib/agile/agile_principles.txt")
    end
  end
end
