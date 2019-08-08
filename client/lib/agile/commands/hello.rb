module Agile
  class CLI < Thor
    desc Rainbow("hello").yellow, "Print hello world"
    def hello
      say set_color "Hello world!", :yellow
    end
  end
end
