module Agile
  class CLI < Thor
    @remote = nil

    desc Rainbow("remote LINK_TO_SERVER").cornflower, Rainbow("Change remote server").darkgoldenrod
    def remote(*server)
      @remote = if server == []
                  "htps://limitless-badlands-65508.herokuapp.com/"
                else
                  "#{server}"
                end
      say "You remote : #{@remote}"
    end
  end
end
