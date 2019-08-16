RSpec.describe Agile::CLI do
  describe "#principles" do
    subject(:cli) { described_class.new }
    principles = <<~PRINCIPLES
      Our highest priority is to satisfy the customer
      through early and continuous delivery
      of valuable software.

      Welcome changing requirements, even late in
      development. Agile processes harness change for
      the customer's competitive advantage.

      Deliver working software frequently, from a
      couple of weeks to a couple of months, with a
      preference to the shorter timescale.

      Business people and developers must work
      together daily throughout the project.

      Build projects around motivated individuals.

      Give them the environment and support they need,
      and trust them to get the job done.

      The most efficient and effective method of
      conveying information to and within a development
      team is face-to-face conversation.

      Working software is the primary measure of progress.

      Agile processes promote sustainable development.

      The sponsors, developers, and users should be able
      to maintain a constant pace indefinitely.

      Continuous attention to technical excellence
      and good design enhances agility.

      Simplicity--the art of maximizing the amount
      of work not done--is essential.

      The best architectures, requirements, and designs
      emerge from self-organizing teams.

      At regular intervals, the team reflects on how
      to become more effective, then tunes and adjusts
      its behavior accordingly.
    PRINCIPLES

    before do
      allow(cli).to receive(:say).with(Terminal::Table)
    end

    it "receive twelwe principles" do
      expect(principles).to eq(File.read("#{Agile::GEM_PATH}/agile/assets/agile_principles.txt"))
    end

    it "shows you table" do
      cli.principles
      expect(cli).to have_received(:say).with(Terminal::Table)
    end
  end
end
