# :reek:Lint/Syntax

module Agile

  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project)
      # some code
    end

    desc "list", "Show projects"
    def list
      # some code
    end

    desc "use <project>", "Select current project"
    def use(project)
      if Project.exists?(name: project)
        # current_project = project # config
        say "Your project: #{project}"
      else
        say "Such a project does not exist. Try again"
      end
    end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "projects", Projects
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "list", List
    subcommand "create", Create
    subcommand "use", Use
    subcommand "invite", Invite
  end
end
