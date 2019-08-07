module Agile
  class CLI < Thor
    desc "hello", "Print hello world"
    def hello
      say "Hello world!"
    end
  end
end
