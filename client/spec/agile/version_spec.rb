require "agile/commands/version"

RSpec.describe Agile::CLI do
  describe "#version" do
    subject(:cli) { described_class.new }

    before do
      allow(cli).to receive(:say).with("agile #{Agile::VERSION}")
    end

    it "has a version number" do
      cli.version

      expect(cli).to have_received(:say).with("agile #{Agile::VERSION}")
    end
  end
end
