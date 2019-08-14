# :reek:Lint/Syntax

module Agile
  class Use < Thor
    desc "update <gitgub> <role>", "Select current project"
    def use(github, role)
      # some code
    end
  end

  class CLI < Thor
    desc Rainbow("users SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with users").darkgoldenrod
    subcommand "update", Update
  end
end
