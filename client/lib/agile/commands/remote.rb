module Agile
  class CLI < Thor
    desc Rainbow("remote LINK_TO_SERVER").cornflower, Rainbow("Change remote server").darkgoldenrod
    def remote(*server)
      @remote = if server == []
                  "htps://limitless-badlands-65508.herokuapp.com/"
                else
                  server.to_s
                end
      say "You remote : #{@remote}"
    end
  end
end
