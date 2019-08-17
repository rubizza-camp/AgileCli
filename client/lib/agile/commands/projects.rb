# :reek:Lint/Syntax
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project_name)  
      response = RestClient.post "#{CONFIG['current_remote']}/api/v1/projects/", { name: project_name }
      if response.body
        say "Successelly create project #{project_name}"
      else
        say "Try again"
      end
    end

    desc "list", "Show projects"
    def list
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      data = JSON.parse(response)
      array = data.map { |hash| hash.values }
      info = array.map { |hash| hash[1]}
      say Rainbow("<<Your Projects>>").cornflower
      info.map { |name| p name }
    end

    desc "use <project>", "Select current project"
    def use(project)
      if CONFIG
        response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      else
        say "You need to add a remote!"
      end
      project_search(response, project)
    end

    desc "delete <project>", "Delete project"
    def delete(project)
      response = RestClient.delete "#{CONFIG['current_remote']}/api/v1/projects/#{project}", { name: project}
      if response.body
        say "Successelly delete project #{project}"
      else
        say "Try again"
      end
    end

    desc "update <project_name> <new_project_name>", "Update project name"
    def update(project, new_project)
      response = RestClient.put "#{CONFIG['current_remote']}/api/v1/projects/#{project}", name: project, new_name: new_project
      if response.body
        say "Successelly update project #{project}"
      else
        say "Try again"
      end
    end
  
    private

    def project_search(response, project)
      array = JSON.parse(response)
      info = array.map { |hash| hash.values }
      names = info.map{ |hash| hash[1] }
      if names.include?(project)
        CONFIG["current_project"] = project
        File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
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
end
