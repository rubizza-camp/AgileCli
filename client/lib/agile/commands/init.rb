# :reek:InstanceVariableAssumption
module Agile
  class CLI < Thor
    include Thor::Actions
    desc Rainbow("init REMOTE_URL").cornflower, Rainbow("Add default remote").darkgoldenrod

    def init(remote)
      error_checking
      if remote =~ URL_PATTERN || remote =~ LOCALHOST_PATTERN
        create_config_file
        write_to_config(remote)
        say "Successfully added new remote!"
      else
        say "It's not a url!"
      end
    end

    private

    def error_checking
      abort "You've already did init! Try to add more remotes" if CONFIG["current_remote"]
    end

    def create_config_file
      `touch #{GEM_PATH}.config.json` if `find "#{GEM_PATH}" -name .config.json`.empty?
    end

    def write_to_config(remote)
      CONFIG["current_remote"] = remote
      CONFIG["remotes"] = [remote]
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    end
  end
end
