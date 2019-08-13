# :reek:Lint/Syntax

module Agile
  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "list", List
    subcommand "create", Create
    subcommand "use", Use
  end

  class Use < Thor
    def use
      #some code
    end
  end

  class List < Thor
    def list
      #some code
    end
  end

  class Create < Thor
    def create
      #some code
    end
  end
end
