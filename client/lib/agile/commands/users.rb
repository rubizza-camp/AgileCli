module Agile
  class Members < Thor
    desc "invite <github_login>", "Add user in project"
    def invite(login)
      RestClient.put"#{CONFIG['current_remote']}/api/v1/userproject/#{login}",
                    project: CONFIG["current_project"], current_user: CONFIG["current_user"], new_user: login
      say "Successfully added new user!"
    end

    desc "role <github_login>", "Assign role to a user"    
    def role(login)
      RestClient.put"#{CONFIG['current_remote']}/api/v1/users/#{login}",
                    project_id: CONFIG["current_project_id"], name: login, role_id: role_type
      say "Successfully updated user's role!"
    end

    private

    def role_type
      cli = HighLine.new
      cli.ask("Choose role type:\n1 - team member\n2 - scrum master\n3 - product owner", Integer)
    end
  end

  class CLI < Thor
    desc Rainbow("users SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with users").darkgoldenrod
    subcommand "users", Members
  end
end
