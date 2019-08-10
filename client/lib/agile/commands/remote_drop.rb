module Agile
  class CLI < Thor
    @remote = nil

    desc Rainbow("remote_drop").cornflower, Rainbow("Drop you remote").darkgoldenrod
    def remote_drop
      @remote = nil
      say "You drop remote with server"
    end
  end
end
