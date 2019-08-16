RSpec.describe Agile::CLI do
  describe "#DoR" do
    subject(:cli) { described_class.new }
    dor = <<~DOR
      All work should have a related Ticket.
      Developer should not start development unless a Ticket is "Ready for development"
      We consider a Ticket "Ready for development" if it meets following requirements:
      
      Ticket Requirements must have:
      
      1. Ticket should have a short title
      2. Ticket should have a clear description
      3. Description should including "How to demo" section
      4. Description may have "Acceptance Criteria" section which includes all important(specific) requirements
      5. All Blocker should be resolved
      6. Ticket can reasonably be "Done" within the Sprint time-box
      7. Ticket should have Estimation
    DOR

    before do
      allow(cli).to receive(:say).with(Terminal::Table)
    end

    it "receive definition of ready" do
      expect(dor).to eq(File.read("#{Agile::GEM_PATH}/agile/assets/definition_of_ready.txt"))
    end

    it "shows you table" do
      cli.DoR
      expect(cli).to have_received(:say).with(Terminal::Table)
    end
  end
end
