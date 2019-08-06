module Agile
  class CLI < Thor

    desc "version", "Displays the version"
    def version
      say "agile #{Agile::VERSION}"
    end

  end
end
