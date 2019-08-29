module Agile
  class Members < Thor
    desc "add <github_login>", "Add user in project"
    def add(login)
      RestClient.put"#{CONFIG["current_remote"]}/api/v1/userproject/#{login}",
                    project: CONFIG["current_project_id"], current_user: CONFIG["current_user"], new_user: login
      say "Successfully added new user!"
    end
  end

  class CLI < Thor
    desc Rainbow("users SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with users").darkgoldenrod
    subcommand "users", Members
  end
end
