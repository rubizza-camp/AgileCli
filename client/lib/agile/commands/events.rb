module Agile
  class Events < Thor
    desc "create", "Add new event"
    def create
      cli = HighLine.new
      event_description = cli.ask("description for event: ", String)
      RestClient.post"#{CONFIG['current_remote']}/api/v1/events/",
                     event_type: type_cli, date: date_cli, start_time: start_time_cli,
                     end_time: end_time_cli, desc: event_description,
                     current_user: CONFIG["current_user"]
      say "Successfully added new event!"
    end

    desc "list", "Show all events"
    def list
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/events/"
      say "<<Project events>>"
      JSON.parse(response).each do |event|
        if event["project_id"] == CONFIG["current_project_id"]
          info = parse_info(event)
          say "#{(event['event_type']).upcase} starts at #{parse_date(event)} #{info[:start]} and ends at #{info[:end]}"
        end
      end
    end

    desc "show <date (yyyy-mm-dd)>", "Show event"
    # :reek:ControlParameter
    def show(date)
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/events/"
      JSON.parse(response).each { |event| puts_info(event) if event["date"] == date }
    end

    private

    def puts_info(event)
      say "Type of event: #{event['event_type']}\nDescription: #{event['description']}"
      say "Start at #{norm_time(event['start_time'])}\nEnd at #{norm_time(event['end_time'])}"
      puts ""
    end

    def parse_info(event)
      { start: norm_time(event["start_time"]),
        end: norm_time(event["end_time"]) }
    end

    def parse_date(event)
      Date.parse(event["date"]).strftime("%B %d")
    end

    def norm_time(param)
      Time.parse(param).strftime("%I:%M")
    end

    def type_cli
      cli = HighLine.new
      puts "0 - scrum\n1 - retro\n2 - planning\n3 - review"
      cli.ask("Choose type of event (select number): ", Integer)
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
