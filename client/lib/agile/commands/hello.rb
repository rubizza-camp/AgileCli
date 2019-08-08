module Agile
  class CLI < Thor
    desc Rainbow("hello").cornflower, Rainbow("Print hello world").darkgoldenrod
    def hello
      say "Hello world!"
    end
  end
end
