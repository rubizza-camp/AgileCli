module Agile
  class CLI < Thor
    desc "principles", "Shows twelwe agile principles"
    def principles
      principles = File.read("lib/agile/agile_principles.txt")
      say principles
    end
  end
end
