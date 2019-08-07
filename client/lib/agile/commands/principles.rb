module Agile
  class CLI < Thor
    desc "principles", "Shows twelwe agile principles"
    def principles
      say "Our highest priority is to satisfy the customer\n
through early and continuous delivery\n
of valuable software.\n"
      say "Welcome changing requirements, even late in\n
development. Agile processes harness change for\n
the customer's competitive advantage.\n"
      say "Deliver working software frequently, from a \n
couple of weeks to a couple of months, with a \n
preference to the shorter timescale.\n"
      say "Business people and developers must work\n
together daily throughout the project.\n"
      say "Build projects around motivated individuals.\n
Give them the environment and support they need,\n
and trust them to get the job done.\n"
      say "The most efficient and effective method of\n
conveying information to and within a development\n
team is face-to-face conversation.\n"
      say "Working software is the primary measure of progress.\n"
      say "Agile processes promote sustainable development.\n
The sponsors, developers, and users should be able\n
to maintain a constant pace indefinitely.\n"
      say "Continuous attention to technical excellence \n
and good design enhances agility.\n"
      say "Simplicity--the art of maximizing the amount \n
of work not done--is essential.\n"
      say "The best architectures, requirements, and designs \n
emerge from self-organizing teams.\n"
      say "At regular intervals, the team reflects on how \n
to become more effective, then tunes and adjusts \n
its behavior accordingly.\n"
    end
  end
end
