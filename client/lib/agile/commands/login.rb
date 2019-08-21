# :reek:InstanceVariableAssumption
module Agile
  class CLI < Thor
    desc Rainbow("login LOGIN_FROM_GITHUB").cornflower, Rainbow("Sign in github.").darkgoldenrod
    def login(username)
      if CONFIG
        write_to_config(username)
        authorize
      else
        say "You need to add a remote!"
      end
    end

    private

    def github_user_login(username)
      @curr_user = JSON.parse(`curl -s -u "#{username}" "#{GITHUB_URL}"`)["login"]
    end

    def authorize
      RestClient.get "#{CONFIG['current_remote']}/api/v1/users/#{@curr_user}"
      say "Hello, #{@curr_user}" if @curr_user
    end

    def write_to_config(username)
      CONFIG["current_user"] = github_user_login(username)
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end
  end
end
