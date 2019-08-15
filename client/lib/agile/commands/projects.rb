# :reek:Lint/Syntax

module Agile
  class Use < Thor
    desc "use <project>", "Select current project"
    def use(project)
      # some code
    end
  end

  class List < Thor
    desc "list", "Show projects"
    def list
      # some code
    end
  end

  class Create < Thor
    desc "create <project>", "Create new project"
    def create(project)
      # api
      if success
        say "Successelly create project #{project}"
      else
        say "Try again"
      end
    end
  end

  class Invite < Thor
    desc "invite <github>", "Add user to your project"
    def invite(github)
      # some code
    end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "list", List
    subcommand "create", Create
    subcommand "use", Use
    subcommand "invite", Invite
  end
end
