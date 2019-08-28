module Agile
  class Events < Thor
    desc "create", "Add new event"
    def create
      cli = HighLine.new
      event_description = cli.ask("description for event: ", String)
      RestClient.post"#{CONFIG['current_remote']}/api/v1/events/",
                     event_type: type_cli, desc: event_description, frequency: frequency_cli,
                     date: date_cli, time: time_cli, current_user: CONFIG["current_user"]
      say "Successfully added new ticket!"
    end

    private

    def type_cli
      cli = HighLine.new
      say "0 - sprint"
      say "1 - scrum"
      say "2 - retro"
      say "3 - planning"
      say "4 - review"
      cli.ask("Choose type of event (select number): ", Integer)
    end

    def frequency_cli
      cli = HighLine.new
      say "0 - daily"
      say "1 - weekly"
      say "2 - monthly"
      cli.ask("Choose frequency for event: ", Integer)
    end

    def date_cli
      cli = HighLine.new
      cli.ask("Select data for event (yyyy.mm.dd): ", String)
    end

    def time_cli
      cli = HighLine.new
      cli.ask("Select time for event (hh:mm): ", String)
    end
  end

  class CLI < Thor
    desc Rainbow("events SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with events").darkgoldenrod
    subcommand "events", Events
  end
end
