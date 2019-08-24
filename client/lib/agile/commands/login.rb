# :reek:InstanceVariableAssumption:TooManyStatements

module Agile
  class CLI < Thor
    desc Rainbow("login").cornflower, Rainbow("Sign in github.").darkgoldenrod
    def login
      error_checking
      `xdg-open "#{GITHUB_URL}/oauth/authorize?client_id=#{CLIENT_ID}"`
      @secret_node = call_cli
      @response = RestClient.get "#{CONFIG['current_remote']}/api/v1/users/#{@secret_node}"
      if JSON.parse(@response)["data"]["attributes"]
        parse_login
      else
        say "Something went wrong"
      end
    end

    private

    def write_to_config(login)
      CONFIG["current_user"] = login
      CONFIG["user_node"] = @secret_node
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end

    def parse_login
      login = JSON.parse(@response)["data"]["attributes"]["github_login"]
      write_to_config(login)
      say "Hello, #{login}!"
    end

    def call_cli
      cli = HighLine.new
      cli.ask("Enter your secret code:  ", String)
    end

    def error_checking
      abort "You haven't done init yet!" unless CONFIG["current_remote"]
    end
  end
end
