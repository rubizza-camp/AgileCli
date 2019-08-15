module Agile
  class CLI < Thor
    desc Rainbow("login LOGIN_FROM_GITHUB").cornflower, Rainbow("Sign in github.").darkgoldenrod

    def login(username)
      @config = JSON.parse(File.read("#{GEM_PATH}.config.json"))
      @config["current_user"] = github_user_login(username)
      File.write("#{GEM_PATH}.config.json", JSON.generate(@config))
      authorize
    end

    private

    def github_user_login(username)
      @curr_user = JSON.parse(`curl -s -u "#{username}" "#{GITHUB_URL}"`)["login"]
      puts @curr_user
    end

    # TODO: ADD REMOTES
    def authorize
      responce = RestClient.get "#{@config["current_remote"]}/api/v1/users/#{@curr_user}"
      say responce.body
    end
  end
end
