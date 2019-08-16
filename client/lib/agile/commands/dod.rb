# rubocop:disable Naming/MethodName
# :reek:UncommunicativeMethodName
module Agile
  class CLI < Thor
    desc Rainbow("DoD").cornflower, Rainbow("Shows you rules of display done tasks").darkgoldenrod
    def DoD
      dod = []
      dod << File.read("#{GEM_PATH}/agile/assets/definition_of_done.txt")
      say Terminal::Table.new title: "Definition of Done", rows: [dod], style: TERMINAL_STYLE
    end
  end
end
# rubocop:enable Naming/MethodName
