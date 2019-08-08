module Agile
  class CLI < Thor
    desc "principles", "Shows twelwe agile principles"
    def principles
      say Agile::PRINCIPLES.to_s
    end
  end
end
