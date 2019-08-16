# :reek:Lint/Syntax
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project_name)
      require 'pry'; binding.pry

      CONFIG
      # load_config

      response = RestClient.post "localhost:3000/api/v1/projects", { name: project_name }

      if response.body
        say "Successelly create project #{project_name}"
      else
        say "Try again"
      end
    end

    desc "list", "Show projects"
    def list
      load_config

      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      data = JSON.parse(response)

      projects_name = data["projects"].map { |project| project["name"] }
      say Rainbow("<<Your Projects>>").cornflower
      projects_name.map { |name| p name }
    end

    desc "use <project>", "Select current project"
    def use(project)
      load_config

      if @config
        data = RestClient.get "#{@config['current_remote']}/api/v1/projects/"
      else
        say "You need to add a remote!"
      end

      project_search(data, project)
    end

    desc "delete <project>", "Delete project"
    def delete(project)
      load_config

      # @config["projects"].find ( |p| p.name ==  project )["uid"]

      response = RestClient.delete "#{@config['current_remote']}/api/v1/projects/#{project}"

      if response.body
        say "Successelly delete project #{project}"
      else
        say "Try again"
      end
    end

    desc "update <project_name> <new_project_name>", "Update project name"
    def update(project, new_project)
      #response = RestClient.update "#{@config['current_remote']}/api/v1/projects/#{project}"
      response = RestClient::Request.execute(method: :put, url: "http://localhost:3000/api/v1/projects/#{project.id}", new_name: new_project )
      if response.body
        say "Successelly update project #{project}"
      else
        say "Try again"
      end
    end
  
    private

    def load_config
      @config = JSON.parse(File.read("#{GEM_PATH}.config.json"))
    end

    def project_search(data, project)

      if JSON.parse(data)["projects"].find { |proj| proj["name"] == project }
        @config["current_project"] = project
        File.write("#{GEM_PATH}.config.json", JSON.generate(@config))
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
