RSpec.describe Agile::CLI do
  describe "#init" do
    subject(:cli) { described_class.new }

    before do
      allow(cli).to receive(:say)
      allow(cli).to receive(:abort)
    end

    it "gives error" do
      Agile::CONFIG['current_remote'] = "smth"
      cli.init("smth")
      expect(cli).to have_received(:abort).with("You've already did init! Try to add more remotes")
    end

    it 'set current remote' do
      cli.init('remote')
      expect(Agile::CONFIG['current_remote']).to eq('remote')
    end

    it 'creates array of remotes' do
      cli.init('remote')
      expect(Agile::CONFIG['remotes']).to eq(['remote'])
    end

    # it 'create config file' do
    #   cli.init('remote')
    #   # require 'pry'; binding.pry
    #   expect(File.exists?("#{Agile::GEM_PATH}/config.json")).to eq(true)
    # end

    it "Successfully finish" do
      cli.init('remote')
      expect(cli).to have_received(:say).with("Successfully added new remote!")
    end
  end
end
