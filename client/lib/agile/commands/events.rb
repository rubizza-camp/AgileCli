module Agile
  class Events < Thor
    desc "create", "Add new event"
    def create
      cli = HighLine.new
      event_description = cli.ask("description for event: ", String)
      RestClient.post"#{CONFIG['current_remote']}/api/v1/events/",
                     event_type: type_cli, frequency: frequency_cli, date: date_cli,
                     start_time: start_time_cli, end_time: end_time_cli, desc: event_description,
                     current_user: CONFIG["current_user"]
      say "Successfully added new event!"
    end

    desc "list", "Show all events"
    def list
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/events/"
      JSON.parse(response).each do |event|
        puts "#{event['event_type']} starting #{event['date']}#{event['start_time']} end at #{event['end_time']}"
      end
    end

    private

    def type_cli
      cli = HighLine.new
      puts "0 - scrum\n1 - retro\n2 - planning\n3 - review"
      cli.ask("Choose type of event (select number): ", Integer)
    end

    def frequency_cli
      cli = HighLine.new
      say "0 - daily\n1 - weekly\n2 - monthly\n3 - not regular"
      cli.ask("Choose frequency for event: ", Integer)
    end

    def date_cli
      cli = HighLine.new
      cli.ask("Select data for event (yyyy.mm.dd): ", String)
    end

    def start_time_cli
      cli = HighLine.new
      cli.ask("Select start time for event (hh:mm): ", String)
    end

    def end_time_cli
      cli = HighLine.new
      cli.ask("Select end time for event (hh:mm): ", String)
    end
  end

  class CLI < Thor
    desc Rainbow("events SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with events").darkgoldenrod
    subcommand "events", Events
  end
end
