RSpec.describe Agile::CLI do
  describe "#dor" do
    subject(:cli) { described_class.new }
    dor =<<-DOR
Definition of Ready

All work should have a related Ticket.
Developer should not start development unless a Ticket is "Ready for development"
We consider a Ticket "Ready for development" if it meets following requirements:

Ticket Requirements must have:

Ticket should have a short title;
Ticket should have a clear description;
Description should including "How to demo" section;
Description may have "Acceptance Criteria" section which includes all important(specific) requirements;
All blocker should be resolved;
Ticket can reasonably be "Done" within the Sprint time-box;
Ticket should have estimation.
    DOR

    before do
      allow(cli).to receive(:say).with(Terminal::Table)
    end

    it "receive definition of ready" do
      expect(dor).to eq(File.read("#{Agile::GEM_PATH}/agile/assets/definition_of_ready.txt"))
    end

    it "shows you table" do
      cli.dor
      expect(cli).to have_received(:say).with(Terminal::Table)
    end
  end
end
