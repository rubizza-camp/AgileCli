RSpec.describe Agile::CLI do
  describe "#remotes" do
    subject(:cli) { described_class.new }
    subject(:remote) { Agile::Remotes.new }

    before do
      allow(cli).to receive(:init)
      allow(remote).to receive(:error_checking)
      allow(remote).to receive(:say)
      # allow(remote).to receive(:p)
    end

    describe "#use" do

      it "check for error" do
        remote.use('remote')
        expect(remote).to have_received(:error_checking)
      end

      it "aborts when remote wasn't added" do
        Agile::CONFIG['remotes'].clear
        remote.use('remote')
        expect(remote).to have_received(:say).with('Try again')
      end

      it "changes remote" do
        Agile::CONFIG['remotes'] << 'another_remote'
        remote.use('another_remote')
        expect(Agile::CONFIG['current_remote']).to eq('another_remote')
      end

      it "writes to config" do
        remote.use('like_a_remote')
        # some logic for this
      end

      it "successfully finishes" do
        Agile::CONFIG['remotes'] << 'remote'
        remote.use('remote')
        expect(remote).to have_received(:say).with("Successfully change remote!")
      end
    end

    describe "#add" do

      it "check for error" do
        remote.add('remote')
        expect(remote).to have_received(:error_checking)
      end

      it "add new remote" do
        remote.add('new_remote')
        expect(Agile::CONFIG['remotes'].include?('new_remote')).to eq(true)
      end

      it "writes to config" do
        remote.add('new_remote')
        # some logic for this
      end

      it "successfully finishes" do
        remote.add('new_remote')
        expect(remote).to have_received(:say).with("Successfully added new remote!")
      end
    end

    describe "#list" do

      it "check for error" do
        remote.list
        expect(remote).to have_received(:error_checking)
      end

      it "target current remote" do
        require 'pry'; binding.pry
        remote.list
        expect(remote).to have_received(:say).with("#{Agile::CONFIG['current_remote']}").exactly(Agile::CONFIG['remotes'].count).times
      end
    end
  end
end
