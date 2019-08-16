RSpec.describe Agile::CLI do
  describe "#DoD" do
    subject(:cli) { described_class.new }
    dod = <<~DOD
      We consider a ticket ‘Done’ when:

      1. The ticket is merged into master and deployed
      2. All "Acceptance Criteria" are met
      3. It is presented to Product Owner
      4. Product Owner agrees that ticket is completed
    DOD

    before do
      allow(cli).to receive(:say).with(Terminal::Table)
    end

    it "receive definition of done" do
      expect(dod).to eq(File.read("#{Agile::GEM_PATH}/agile/assets/definition_of_done.txt"))
    end

    it "shows you table" do
      cli.DoD
      expect(cli).to have_received(:say).with(Terminal::Table)
    end
  end
end
