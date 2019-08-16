# :reek:Lint/Syntax
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project)
      @config = JSON.parse(File.read("#{GEM_PATH}.config.json"))
      responce = RestClient.get "#{@config['current_remote']}/api/v1/projects/#{project}"
      if responce.body
        say "Successelly create project #{project}"
      else
        say "Try again"
      end
    end

    desc "list", "Show projects"
    def list
      @config = JSON.parse(File.read("#{GEM_PATH}.config.json"))
      responce = RestClient.get "#{@config['current_remote']}/api/v1/projects/"
      data = JSON.parse(responce)
      projects_name = data["projects"].map { |name| name["name"] }
      say Rainbow("<<Your Projects>>").cornflower
      projects_name.map { |name| p name }
    end

    desc "use <project>", "Select current project"
    def use(project)
      @config = JSON.parse(File.read("#{GEM_PATH}.config.json"))
      if @config
        data = RestClient.get "#{@config['current_remote']}/api/v1/projects/"
      else
        say "You need to add a remote!"
      end
      project_search(data, project)
    end

    private

    def project_search(data, project)
      if JSON.parse(data)["projects"].find { |proj| proj["name"] == project }
        @config["current_project"] = project
        File.write("#{GEM_PATH}.config.json", JSON.generate(@config))
        say "Your project: #{project}"
      else
        say "Such a project does not exist. Try again"
      end
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
