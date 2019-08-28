module Agile
  class Tickets < Thor
    desc "create <ticket>", "Add new ticket"
    def create(ticket)
      ticket_name = ticket
      cli = HighLine.new
      ticket_description = cli.ask("description for ticket: ", String)
      RestClient.post"#{CONFIG['current_remote']}/api/v1/tickets/",
                     project_id: CONFIG["current_project_id"], name: ticket_name,
                     user: CONFIG["current_user"], desc: ticket_description
      say "Successfully added new ticket!"
    end

    desc "list", "Tickets list"
    # :reek:FeatureEnvy
    def list
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/"
      info = JSON.parse(response)
      info.each { |ticket| puts ticket["name"] if ticket["project_id"] == CONFIG["current_project_id"] }
    end

    desc "show <name_ticket>", "Show ticket"
    def show(ticket)
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}"
      row = JSON.parse(response)
      say "Ticket: #{row['data']['attributes']['name']}"
      say "Description: #{row['data']['attributes']['description']}"
    end

    desc "update <ticket>", "update ticket"
    def update(ticket)
      choice = HighLine.new
      answer = choice.ask("Choose what you need to edit : name or description (N or D): ", String)
      if answer == "N"
        update_name(ticket)
      elsif answer == "D"
        update_description(ticket)
      else
        say "Try again"
      end
    end

    # desc "take <ticket>", "Take ticket"
    # def take(ticket)
    #   # call api to take ticket
    #   CONFIG["tickets"].push(ticket)
    #   File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    #   puts "you take ticket"
    # end
    #
    # desc "my_list", "Your tickets list"
    # def my_list
    #   CONFIG["tickets"].each do |name|
    #     if name == CONFIG["tickets"]
    #       say "* #{name}"
    #     else
    #       say name
    #     end
    #   end
    # end
    private

    def update_name(ticket)
      choice = HighLine.new
      new_ticket = choice.ask("Enter new name of ticket: ", String)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}", name: ticket, new_name: new_ticket, type: 1
      say "Updated from #{ticket} to #{new_ticket}"
    end

    def update_description(ticket)
      choice = HighLine.new
      new_description = choice.ask("Enter new description of ticket: ", String)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}",
                     name: ticket, new_description: new_description
      say "Updated description to #{new_description}"
    end
  end

  class CLI < Thor
    desc Rainbow("tickets SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with tickets").darkgoldenrod
    subcommand "tickets", Tickets
  end
end
