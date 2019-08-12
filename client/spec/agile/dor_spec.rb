RSpec.describe Agile::CLI do
  describe "#dor" do
    subject(:cli) { described_class.new }

    before do
      allow(cli).to receive(:say).with(File.read("lib/agile/assets/definition_of_ready.txt"))
    end

    it "helps you to make correct item" do
      cli.dor

      expect(cli).to have_received(:say).with(File.read("lib/agile/assets/definition_of_ready.txt"))
    end
  end
end
