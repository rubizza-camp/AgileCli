module Agile
  class CLI < Thor
    desc Rainbow("values").cornflower, Rainbow("Shows core agile values").darkgoldenrod
    def values
      say Agile::VALUES.to_s
    end
  end
end
