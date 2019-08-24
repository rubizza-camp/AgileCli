# :reek:Lint/Syntax
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project_name)
      error_checking
      response = RestClient.post "#{CONFIG['current_remote']}/api/v1/projects/",
                 name: project_name,
                 current_user: CONFIG["current_user"]
      if response.body
        say "Successfully created project #{project_name}"
      else
        say "Try again"
      end
    end

    desc "list", "Show projects"
    def list
      error_checking
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      say Rainbow("<<Your Projects>>").cornflower
      JSON.parse(response).map { |hash| p hash.values[1] }
    end

    desc "use <project>", "Select current project"
    def use(project)
      error_checking
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      project_search(response, project)
    end

    desc "delete <project>", "Delete project"
    def delete(project)
      error_checking
      response = RestClient.delete "#{CONFIG['current_remote']}/api/v1/projects/#{project}", name: project
      if response.body
        say "Successfully deleted project #{project}"
      else
        say "Try again"
      end
    end

    desc "update <project_name> <new_project_name>", "Update project name"
    def update(project, new_project)
      error_checking
      response = RestClient.put "#{CONFIG['current_remote']}/api/v1/projects/#{project}", name: project, new_name: new_project
      if response.body
        say "Successfully updated project #{project}"
      else
        say "Try again"
      end
    end

    private

    def error_checking
      abort "You haven't done init yet!" unless CONFIG["current_remote"]
      abort "Please, log in!" unless CONFIG["current_user"]
    end

    def project_search(response, project)
      info = JSON.parse(response).map { |hash| hash.values[1] }
      if info.include?(project)
        CONFIG["current_project"] = project
        File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
        say "Your project: #{project}"
      else
        say "Such project does not exist. Try again"
      end
    end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "projects", Projects
  end
end
