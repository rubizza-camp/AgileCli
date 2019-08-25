module Agile
  class Tickets < Thor
    desc "take <ticket>", "Take ticket"
    def take(ticket)
      # call api to take ticket
      CONFIG["tickets"].push(ticket)
      File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
      puts "you take ticket"
    end

    desc "add <ticket>", "Add new ticket"
    def add(ticket)
      ticket_name = ticket
      ticket_description = cli_for_description
      # call api with name: ticket_name, description: ticket_description
      say "Successfully added new ticket!"
    end

    desc "list", "Tickets list"
    def list
      # call api to see all tickets
    end

    desc "my_list", "Your tickets list"
    def my_list
      CONFIG["tickets"].each do |name|
        if name == CONFIG["tickets"]
          say "* #{name}"
        else
          say name
        end
      end
    end

    desc "update <ticket>", "update ticket"
    def update(ticket)
      choice = cli_for_change
      if choice == name
        new_name = call_cli_name
        # call api to update
      else
        new_description = call_cli_desc
        # call api to update
      end
      puts "you update ticket"
    end

    desc "delete <ticket>", "Delete ticket"
    def delete(ticket)
      # call api to delete ticket
      puts "you delete ticket"
    end
  end

  private

  def cli_for_description
    cli = HighLine.new
    cli.ask("description for ticket: ", String)
  end

  def cli_for_change
    cli = HighLine.new
    cli.ask("name or description change? : ", String)
  end

  def call_cli_name
    cli = HighLine.new
    cli.ask("write new name : ", String)
  end

  def call_cli_desc
    cli = HighLine.new
    cli.ask("write new description : ", String)
  end
  class CLI < Thor
    desc Rainbow("tickets SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with tickets").darkgoldenrod
    subcommand "tickets", Tickets
  end
end
