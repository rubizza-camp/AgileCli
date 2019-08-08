module Agile
  class CLI < Thor
    desc Rainbow("version").cornflower, Rainbow("Displays the version").darkgoldenrod
    def version
      say "agile #{Agile::VERSION}"
    end
  end
end
