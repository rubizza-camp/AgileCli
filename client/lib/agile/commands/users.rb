module Agile
  class Members < Thor
    desc "invite <github_login>", "Add user in project"
    def invite(login)
      error_checking_users
      find_user(login)
      if @users_array.include?(login)
        RestClient.put "#{CONFIG['current_remote']}/api/v1/userproject/#{login}",
                       project: CONFIG["current_project"], current_user: CONFIG["current_user"], new_user: login
        say "Successfully added new user!"
      else
        say "There is no such user!"
      end
    end

    desc "role <github_login>", "Assign role to a user"
    def role(login)
      error_checking_users
      RestClient.put"#{CONFIG['current_remote']}/api/v1/users/#{login}",
                    project_id: CONFIG["current_project_id"], name: login, role_id: role_type
      say "Successfully updated user's role!"
    end

    private

    def find_user(login)
      @users_array = []
      all_users = RestClient.get "#{CONFIG['current_remote']}/api/v1/users"
      JSON.parse(all_users).each do |hash|
        @users_array.push(login) if hash["github_login"] == login
      end
    end

    def error_checking_users
      abort "You haven't done init yet!" unless CONFIG["current_remote"]
      abort "Please, log in!" unless CONFIG["current_user"]
      abort "Please, choose a project to work with!" unless CONFIG["current_project"]
    end

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
