module Agile
  class CLI < Thor
    class << self
      def help(shell, subcommand = false)
        list = printable_commands(true, subcommand)
        Thor::Util.thor_classes_in(self).each do |klass|
          list += klass.printable_commands(false)
        end
        list.sort! { |a, b| a[0] <=> b[0] }
        list.reject! {|l| l[0].split[1] == 'help'}

        if defined?(@package_name) && @package_name
          shell.say "#{@package_name} commands:"
        else
          shell.say Rainbow("Commands:").whitesmoke
        end

        shell.print_table(list, :indent => 2, :truncate => true)
        shell.say
        class_options_help(shell)
        shell.say Rainbow('All commands can be run with -h (or --help) for more information.').whitesmoke
      end
    end
  end
end
