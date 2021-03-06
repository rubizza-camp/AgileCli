module Agile
  class Remotes < Thor
    desc "use <remotes url>", "Use remote"
    def use(remote)
      error_checking_remotes
      if CONFIG["remotes"].include?(remote)
        CONFIG["current_remote"] = remote
        File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
        say "Successfully changed current remote!"
      else
        say "Try again"
      end
    end

    desc "add <remotes url>", "Add remote url"
    def add(remote)
      error_checking_remotes
      CONFIG["remotes"].push(remote)
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
      say "Successfully added new remote!"
    end

    desc "list", "Remotes list"
    def list
      error_checking_remotes
      CONFIG["remotes"].each do |name|
        if name == CONFIG["current_remote"]
          say "* #{name}"
        else
          say name
        end
      end
    end

    private

    def error_checking_remotes
      abort "You haven't done init yet!" unless CONFIG["current_remote"]
      abort "Please, log in!" unless CONFIG["current_user"]
      abort "You have no remotes. Try to init!" unless CONFIG["remotes"]
    end
  end

  class CLI < Thor
    desc Rainbow("remotes SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with remotes").darkgoldenrod
    subcommand "remotes", Remotes
  end
end
