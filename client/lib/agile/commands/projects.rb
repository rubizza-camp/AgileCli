# :reek:Lint/Syntax
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project)
      responce = RestClient.get "#{@config['current_remote']}#{project}"
      if responce.body
        say "Successelly create project #{project}"
      else
        say "Try again"
      end
    end

    desc "list", "Show projects"
    def list
      data = JSON.parse(RestClient.get(API_PROJECTS))
      projects_name = data["projects"].map { |name| name["name"] }
      say Rainbow("<<Your Projects>>").cornflower
      projects_name.map { |name| p name }
    end
    #
    # desc "use <project>", "Select current project"
    # def use(project)
    #   # some code
    # end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "projects", Projects
  end
end
