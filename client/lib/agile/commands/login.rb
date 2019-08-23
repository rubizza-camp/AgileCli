# :reek:InstanceVariableAssumption:TooManyStatements
require "bcrypt"

module Agile
  class CLI < Thor
    desc Rainbow("login").cornflower, Rainbow("Sign in github.").darkgoldenrod
    def login
      if CONFIG
        `xdg-open "#{GITHUB_URL}/oauth/authorize?client_id=#{CLIENT_ID}"`
        @secret_node = call_cli
        @response = RestClient.get "#{CONFIG['current_remote']}/api/v1/users/#{@secret_node}"
        if JSON.parse(@response.body)["data"]
          parse_login
        else
          say "Something went wrong"
        end
      else
        say "You need to init!"
      end
    end

    private

    def write_to_config(login)
      CONFIG["current_user"] = login[0]
      CONFIG["user_node"] = @secret_node
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end

    def parse_login
      login = JSON.parse(@response).map { |hash| hash[1]["attributes"]["github_login"] }
      write_to_config(login)
      say "Hello, #{login[0]}!"
    end

    def call_cli
      cli = HighLine.new
      cli.ask("Enter your secret code:  ")
    end
  end
end
