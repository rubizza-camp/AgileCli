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
        if proj["name"] == CONFIG["current_project"]
          say "* #{proj['name']}"
        else
          say proj["name"]
        end
      end
    end

    desc "show <project>", "Show project"
    def show(project)
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/#{project}"
      row = JSON.parse(response)
      say "Project: #{row['data']['attributes']['name']}"
      say "Description: #{row['data']['attributes']['description']}"
    end

    desc "use <project>", "Select current project"
    def use(project)
      error_checking_projects
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/projects/"
      project_search(response, project)
    end

    desc "update <project_name> ", "Update project"
    def update(project)
      error_checking_projects
      choice = HighLine.new
      answer = choice.ask("Choose what you want to edit: name or description (N or D): ", String)
      if answer == "N"
        update_name(project)
      elsif answer == "D"
        update_description(project)
      else
        say "Try again"
      end
    end

    private

    def update_name(project)
      choice = HighLine.new
      new_project = choice.ask("Enter new name of project: ", String)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/projects/#{project}",
                     name: project, new_name: new_project, type: 1,
                     current_user: CONFIG["current_user"]
      say "Updated from #{project} to #{new_project}"
    end

    def update_description(project)
      choice = HighLine.new
      new_description = choice.ask("Enter new description for project: ", String)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/projects/#{project}",
                     name: project, new_description: new_description,
                     current_user: CONFIG["current_user"]
      say "Updated description to #{new_description}"
    end

    def error_checking_projects
      abort "You haven't done init yet!" unless CONFIG["current_remote"]
      abort "Please, log in!" unless CONFIG["current_user"]
    end

    def project_search(response, project)
      info = JSON.parse(response).map(&:values)
      id_pr = info.map { |arr| arr[0] if arr[1] == project }
      id_pr.delete_if(&:nil?)
      if id_pr.empty?
        say "Such project does not exist. Try again"
      else
        write_to_config(id_pr, project)
        say "Your current project: #{project}"
      end
    end

    def write_to_config(id_pr, project)
      CONFIG["current_project_id"] = id_pr.first
      CONFIG["current_project"] = project
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end
  end

  class CLI < Thor
    desc Rainbow("projects SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with projects").darkgoldenrod
    subcommand "projects", Projects
  end
end
