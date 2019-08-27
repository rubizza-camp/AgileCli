module Agile
  class Tickets < Thor
    # desc "take <ticket>", "Take ticket"
    # def take(ticket)
    #   # call api to take ticket
    #   CONFIG["tickets"].push(ticket)
    #   File.write("#{GEM_PATH}.config.json", JSON.generate(CONFIG))
    #   puts "you take ticket"
    # end

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
    def list
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/"
      JSON.parse(response).each do |ticket|
        say ticket["name"]
      end
    end

    desc "check <name_ticket>", "Check ticket"
    def check(ticket)
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}"
      row = JSON.parse(response)
      say "Ticket: #{row['data']['attributes']['name']}"
      say "Description: #{row['data']['attributes']['description']}"
    end

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
    #
    #   desc "update <ticket>", "update ticket"
    #   def update(ticket)
    #     choice = HighLine.new
    #     choice.ask("Choose what you need to edit : name or description (N or D)", String)
    #     if choice == "N"
    #       # call api for name
    #     elsif choice == "D"
    #       # call api for description
    #     else
    #       say "Try again"
    #     end
    #   end
    #
    #   desc "delete <ticket>", "Delete ticket"
    #   def delete(ticket)
    #     call api to delete ticket
    #     puts "you delete ticket"
    #   end
  end

  class CLI < Thor
    desc Rainbow("tickets SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with tickets").darkgoldenrod
    subcommand "tickets", Tickets
  end
end
