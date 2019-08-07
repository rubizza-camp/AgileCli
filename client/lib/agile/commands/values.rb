module Agile
  class CLI < Thor
    desc "values", "Shows core agile values"
    def values
      say "Individuals and interactions over processes and tools"
      say "Working software over comprehensive documentation"
      say "Customer collaboration over contract negotiation"
      say "Responding to change over following a plan"
    end
  end
end
