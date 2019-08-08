module Agile
  class CLI < Thor
    desc "principles", "Shows twelwe agile principles"
    def principles
      say "#{Agile::PRINCIPLES}"
    end
  end
end
