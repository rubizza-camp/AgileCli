# :reek:Lint/Syntax
module Agile
  class Projects < Thor
    desc "create <project>", "Create new project"
    def create(project_name)
      error_checking_projects
      response = RestClient.post "#{CONFIG['current_remote']}/api/v1/projects/",
                                 name: project_name, current_user: CONFIG["current_user"]
      if response.body
        say "Successfully created project #{project_name}"
      else
        say "Try again"
      end
    end

    desc "list", "Show projects"
    def list
      error_checking_projects
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/userproject/#{CONFIG['current_user']}"
      say Rainbow("<<Your Projects>>").cornflower
      JSON.parse(response).each do |proj|
        say proj.first.values[1]
      end
    end

    desc "use <project>", "Select current project"
    def use(project)
      error_checking_projects
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      project_search(response, project)
    end

    desc "update <project_name> <new_project_name>", "Update project name"
    def update(project, new_project)
      error_checking_projects
      resp = RestClient.get "#{CONFIG['current_remote']}/api/v1/userproject/#{CONFIG['current_user']}"
      pr_list = JSON.parse(resp).map { |array| array.map { |hash| hash.values_at("name").include?(project) } }
      if pr_list.include?([true])
        RestClient.put "#{CONFIG['current_remote']}/api/v1/projects/#{project}", name: project, new_name: new_project
        say "Updated from #{project} to #{new_project}"
      else
        say "Error"
      end
    end

    private

    def error_checking_projects
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
