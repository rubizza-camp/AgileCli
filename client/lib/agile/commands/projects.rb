module Agile
  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "list", List
    subcommand "create", Create
    subcommand "use", Use
  end

  class Use < Thor
    #some code
  end

  class List < Thor
    #some code
  end

  class Create < Thor
    #some code
  end
end
