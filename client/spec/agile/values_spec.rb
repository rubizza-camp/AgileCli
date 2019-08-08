require "agile/commands/hello"

RSpec.describe Agile::CLI do
  describe "#values" do
    subject(:cli) { described_class.new }

    before do
      allow(cli).to receive(:say).with(File.read("lib/agile/agile_values.txt"))
    end

    it "returns agile values" do
      cli.values
      expect(cli).to have_received(:say).with(File.read("lib/agile/agile_values.txt"))
    end
  end
end
