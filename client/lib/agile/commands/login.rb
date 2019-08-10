module Agile
  class CLI < Thor
    include Thor::Actions
    desc Rainbow("login LOGIN_FROM_GITHUB").cornflower, Rainbow("Sign in github.").darkgoldenrod
    def login(username)
      run %{`which curl` -u #{username} #{GITHUB_URL} }
    end
  end
end
