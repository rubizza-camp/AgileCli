# :reek:InstanceVariableAssumption
module Agile
  class CLI < Thor
    include Thor::Actions
    desc Rainbow("init REMOTE_URL").cornflower, Rainbow("Add default remote").darkgoldenrod

    def init(remote)
      create_config_file
      @config = read_config_content
      @config["current_remote"] = remote
      File.write("#{GEM_PATH}.config.json", JSON.generate(@config))
      say "Successfully added new remote!"
    end

    private

    def read_config_content
      if File.read("#{GEM_PATH}.config.json").empty?
        {}
      else
        JSON.parse(File.read("#{GEM_PATH}.config.json"))
      end
    end

    def create_config_file
      `touch #{GEM_PATH}.config.json` if `find "#{GEM_PATH}" -name .config.json`.empty?
    end
  end
end
