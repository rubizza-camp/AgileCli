require "json"
require "rest-client"

module Agile
  class CLI < Thor
    include Thor::Actions
    desc Rainbow("login LOGIN_FROM_GITHUB").cornflower, Rainbow("Sign in github.").darkgoldenrod
  
    def login(username)
      create_config_file
      config = read_config_content
      config["current_user"] = github_user_login(username)
      File.write("#{GEM_PATH}.config.json", JSON.generate(config))
      authorize(config["current_user"])
    end

    private

    def github_user_login(username)
      JSON.parse(`curl -s -u "#{username}" "#{GITHUB_URL}"`)["login"]
    end

    def create_config_file
      `touch #{GEM_PATH}.config.json` if `find "#{GEM_PATH}" -name .config.json`.empty?
    end

    def read_config_content
      if File.read("#{GEM_PATH}.config.json").empty?
        {}
      else
        JSON.parse(File.read("#{GEM_PATH}.config.json"))
      end
    end

    def authorize(curr_user)
      JSON.parse(`curl -s https://agile-cli.herokuapp.com/api/v1/users/#{curr_user}"`)["github_login"]
     # r = RestClient.get "https://agile-cli.herokuapp.com/api/v1/users/#{curr_user}"
     # say r.body
      puts "hello"
    end
  end
end
