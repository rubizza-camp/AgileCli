RSpec.describe Agile::CLI do
  describe "#values" do
    subject(:cli) { described_class.new }
    values =<<-VALUES
Individuals and interactions over processes and tools

Working software over comprehensive documentation

Customer collaboration over contract negotiation

Responding to change over following a plan
    VALUES

    before do
      allow(cli).to receive(:say).with(Terminal::Table)
    end

    it "receive agile values" do
      expect(values).to eq(File.read("#{Agile::GEM_PATH}/agile/assets/agile_values.txt"))
    end

    it "shows you table" do
      cli.values
      expect(cli).to have_received(:say).with(Terminal::Table)
    end
  end
end
