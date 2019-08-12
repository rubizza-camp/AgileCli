RSpec.describe Agile::CLI do
  describe "#principles" do
    subject(:cli) { described_class.new }

    before do
      allow(cli).to receive(:say).with(File.read("lib/agile/assets/agile_principles.txt"))
    end

    it "returns twelwe principles" do
      cli.principles

      expect(cli).to have_received(:say).with(File.read("lib/agile/assets/agile_principles.txt"))
    end
  end
end
