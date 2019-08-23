# :reek:InstanceVariableAssumption
module Agile
  class CLI < Thor
    desc Rainbow("login").cornflower, Rainbow("Sign in github.").darkgoldenrod
    def login
      if CONFIG
        `open "#{GITHUB_URL}/oauth/authorize?client_id=#{CLIENT_ID}"`
        secret_node = call_cli
        response = RestClient.get "#{CONFIG['current_remote']}/api/v1/users/#{secret_node}"
        login = JSON.parse(response).map { |hash| hash[1]["attributes"]["github_login"] }
        write_to_config(secret_node, login)
        say "Hello, #{login[0]}!"
      else
        say "You need to init!"
      end
    end

    private

    def write_to_config(secret_node, login)
      CONFIG["current_user"] = login[0]
      CONFIG["user_node"] = secret_node
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end

    def call_cli
      cli = HighLine.new
      cli.ask("Enter your secret code:  ")
    end
  end
end
