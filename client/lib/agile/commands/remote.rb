module Agile
  class Remote < Thor
    desc "add <url>", "Adds a remote"
    def add(url)
      @remote = url
      say "You remote : #{@remote}"
    end

    desc "drop", "Drops your remote"
    def drop
      @remote = nil
      say "You droped remote with server"
    end
  end

  class CLI < Thor
    desc Rainbow("remote SUBCOMMAND ...ARGS").cornflower, Rainbow("Work with remote").darkgoldenrod
    subcommand "remote", Remote
  end
end
