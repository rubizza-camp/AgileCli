module Agile
  class CLI < Thor
    desc Rainbow("manifesto").cornflower, Rainbow("Shows manifesto").darkgoldenrod
    def manifesto
      manifest = []
      manifest << File.read("#{`gem which agile`.chomp.chomp('agile.rb')}/agile/assets/manifesto.txt")
      say Terminal::Table.new title: "Manifesto", rows: [manifest], style: TERMINAL_STYLE
    end
  end
end
