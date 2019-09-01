module Agile
  class Tickets < Thor
    desc "create <ticket>", "Add new ticket"
    def create(ticket)
      ticket_name = ticket
      cli = HighLine.new
      ticket_description = cli.ask("description for ticket: ", String)
      RestClient.post"#{CONFIG['current_remote']}/api/v1/tickets/",
                     project_id: CONFIG["current_project_id"], name: ticket_name,
                     user: CONFIG["current_user"], desc: ticket_description, status: ticket_status
      say "Successfully added new ticket!"
    end

    desc "list", "Tickets list"
    def list
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/"
      info = JSON.parse(response)
      print_tickets_list(info)
    end

    desc "show <name_ticket>", "Show ticket"
    def show(ticket)
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}"
      row = JSON.parse(response)
      output_ticket(row["data"]["attributes"])
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

    desc "take <ticket>", "Take ticket"
    def take(ticket)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}",
                     name: ticket, user: CONFIG["current_user"], type: 2
      say "You take ticket #{ticket}"
    end

    desc "status <ticket>", "Update ticket status"
    def status(ticket)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}",
                     name: ticket, status: ticket_status, type: 3, project_id: CONFIG["current_project_id"]
      say "You take ticket #{ticket}"
    end

    desc "archive", "View archived tickets"
    def archive
      response = RestClient.get "#{CONFIG['current_remote']}/api/v1/tickets/"
      info = JSON.parse(response)
      info.each do |ticket|
        archive_ticket(ticket) if ticket["project_id"] == CONFIG["current_project_id"] && ticket["status"] == "archived"
      end
    end

    private

    def output_ticket(row)
      say "Ticket: #{row['name']}"
      say "Description: #{row['description']}"
      say "Status: #{row['status']}"
      say "Owner: #{row['owner']}"
    end

    def archive_ticket(ticket)
      say ticket["name"]
    end

    def ticket_status
      cli = HighLine.new
      puts "0 - ToDo\n1 - Review\n2 - Merged\n3 - In progress\n4 - Done\n5 - Archived"
      cli.ask("Choose status of ticket (select number): ", Integer)
    end

    def update_name(ticket)
      choice = HighLine.new
      new_ticket = choice.ask("Enter new name of ticket: ", String)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}",
                     name: ticket, new_name: new_ticket, type: 1,
                     user: CONFIG["current_user"], project_id: CONFIG["current_project_id"]
      say "Updated from #{ticket} to #{new_ticket}"
    end

    def update_description(ticket)
      choice = HighLine.new
      new_description = choice.ask("Enter new description of ticket: ", String)
      RestClient.put "#{CONFIG['current_remote']}/api/v1/tickets/#{ticket}",
                     name: ticket, new_description: new_description,
                     user: CONFIG["current_user"]
      say "Updated description to #{new_description}"
    end

    def print_arr_to_do(arr)
      @s_to_do = ""
      arr.each do |element|
        @s_to_do += element.to_s + "\n"
      end
    end

    def print_arr_review(arr)
      @s_review = ""
      arr.each do |element|
        @s_review += element.to_s + "\n"
      end
    end

    def print_arr_merged(arr)
      @s_merged = ""
      arr.each do |element|
        @s_merged += element.to_s + "\n"
      end
    end

    def print_arr_in_progress(arr)
      @s_in_progress = ""
      arr.each do |element|
        @s_in_progress += element.to_s + "\n"
      end
    end

    def print_arr_done(arr)
      @s_done = ""
      arr.each do |element|
        @s_done += element.to_s + "\n"
      end
    end

    def tickets_to_arrays(my_tickets)
      @to_do = []
      @review = []
      @merged = []
      @in_progress = []
      @done = []

      my_tickets.each do |ticket|
        case ticket["status"]
        when "todo"
          @to_do.push(ticket["name"])
        when "review"
          @review.push(ticket["name"])
        when "merged"
          @merged.push(ticket["name"])
        when "in_progress"
          @in_progress.push(ticket["name"])
        when "done"
          @done.push(ticket["name"])
        end
      end
    end

    def parse_tickets(all_tickets)
      my_tickets = []
      all_tickets.each { |ticket| my_tickets << ticket if ticket["project_id"] == CONFIG["current_project_id"] }
      tickets_to_arrays(my_tickets)
    end

    def print_all_arrays
      print_arr_to_do(@to_do)
      print_arr_review(@review)
      print_arr_merged(@merged)
      print_arr_in_progress(@in_progress)
      print_arr_done(@done)
    end

    def print_tickets_list(all_tickets)
      parse_tickets(all_tickets)
      print_all_arrays
      table = Terminal::Table.new do |tbl|
        tbl.title = CONFIG["current_project"]
        tbl.headings = ["todo", "review", "merged", "in_progress", "done"]
        tbl.rows = [[@s_to_do, @s_review, @s_merged, @s_in_progress, @s_done]]
      end
      say table
    end
  end

  class CLI < Thor
    desc Rainbow("tickets SUBCOMMAND ...ARGS").cornflower, Rainbow("Command for work with tickets").darkgoldenrod
    subcommand "tickets", Tickets
  end
end
