# :reek:InstanceVariableAssumption
module Agile
  class CLI < Thor
    desc Rainbow("login").cornflower, Rainbow("Sign in github.").darkgoldenrod
    def login
      if CONFIG
        write_to_config
        authorize
      else
        say "You need to add a remote!"
      end
    end

    private

    def github_user_login
      `open "#{GITHUB_URL}/oauth/authorize?client_id=#{CLIENT_ID}"`

    end

    def authorize
      RestClient.get "#{CONFIG['current_remote']}/api/v1/users/#{@curr_user}"
      say "Hello, #{@curr_user}" if @curr_user
    end

    def write_to_config
      CONFIG["current_user"] = github_user_login
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end
  end
end