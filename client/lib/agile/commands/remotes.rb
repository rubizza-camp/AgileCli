module Agile
  class Remotes < Thor
    desc "use <remotes url>", "Use remote"
    def use(remote)
      if CONFIG["remotes"].include?(remote)
        CONFIG["current_remote"] = remote
        File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
        say "Successfully change remote!"
      else
        say "Try again"
      end
    end

    desc "add <remotes url>", "Add remote url"
    def add(remote)
      CONFIG["remotes"].push(remote)
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
      say "Successfully added new remote!"
    end

    desc "list", "Remotes list"
    def list
      CONFIG["remotes"].each do |name|
        if name == CONFIG["current_remote"]
          p "* #{name}"
        else
          p name
        end
      end
    end
  end

  class CLI < Thor
    desc Rainbow("remotes SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with remotes").darkgoldenrod
    subcommand "remotes", Remotes
  end
end
