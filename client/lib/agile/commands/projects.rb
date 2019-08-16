# :reek:Lint/Syntax

module Agile

  class Projects < Thor
    # desc "create <project>", "Create new project"
    # def create(project)
    #   # some code
    # end

    # desc "list", "Show projects"
    # def list
    #   # some code
    # end

    desc "use <project>", "Select current project"
    def use(project)
      @config = JSON.parse(File.read("#{GEM_PATH}.config.json"))

      if @config
        data = RestClient.get "#{@config['current_remote']}/api/v1/projects/"
      else
        say "You need to add a remote!"
      end

      pr = JSON.parse(data)["projects"]
      if res = JSON.parse(data)["projects"].find { |proj| proj['name'] == "#{project}" }
        @config["current_project"] = project
        File.write("#{GEM_PATH}.config.json", JSON.generate(@config))
        say "Your project: #{project}"
      else
        say "Such a project does not exist. Try again"
      end
      require 'pry'; binding.pry
    end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "projects", Projects
  end
end
