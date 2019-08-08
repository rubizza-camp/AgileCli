module Agile
  class CLI < Thor
    desc "principles", "Shows twelwe agile principles"
    def principles
      say File.read("lib/agile/agile_principles.txt")
    end
  end
end
