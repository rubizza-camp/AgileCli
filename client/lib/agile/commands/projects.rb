module Agile
  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "list", #укажи класс
    subcommand "create", #укажи класс
    subcommand "use" #укажи класс
  end
end
