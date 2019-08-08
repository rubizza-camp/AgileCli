require "agile/commands/hello"

RSpec.describe Agile::CLI do
  describe "#hello" do
    subject(:cli) { described_class.new }

    before do
      allow(cli).to receive(:say).with("Hello world!")
    end

    it "has a version number" do
      cli.hello

      expect(cli).to have_received(:say).with("Hello world!")
    end
  end
end
