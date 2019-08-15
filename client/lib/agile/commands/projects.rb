require "json"
# :reek:Lint/Syntax
require "pry"
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project)
      # some code
    end

    desc "list", "Show projects"
    def list
      say "wow"
      data = JSON.parse(`curl -s -G https://agile-cli.herokuapp.com/api/v1/projects/`)
        binding.pry
       say data
    end

    desc "use <project>", "Select current project"
    def use(project)
      # some code
    end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "projects", Projects
  end
end
