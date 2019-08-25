RSpec.describe Agile::CLI do
  describe "#remotes" do
    subject(:remote) { Agile::Remotes.new }

    before do
      Agile::CONFIG["remotes"].clear
      Agile::CONFIG["current_user"] = "smone"
      allow(remote).to receive(:error_checking_remotes)
      allow(remote).to receive(:say)
    end

    describe "#use" do
      it "check for error" do
        # require 'pry'; binding.pry
        remote.use("remote")
        expect(remote).to have_received(:error_checking_remotes)
      end

      it "aborts when remote wasn't added" do
        Agile::CONFIG["remotes"].clear
        remote.use("remote")
        expect(remote).to have_received(:say).with("Try again")
      end

      it "changes remote" do
        Agile::CONFIG["remotes"] << "another_remote"
        remote.use("another_remote")
        expect(Agile::CONFIG["current_remote"]).to eq("another_remote")
      end

      it "writes to config" do
        remote.use("like_a_remote")
        # some logic for this
      end

      it "successfully finishes" do
        Agile::CONFIG["remotes"] << "remote"
        remote.use("remote")
        expect(remote).to have_received(:say).with("Successfully changed current remote!")
      end
    end

    describe "#add" do
      it "check for error" do
        remote.add("remote")
        expect(remote).to have_received(:error_checking_remotes)
      end

      it "add new remote" do
        remote.add("new_remote")
        expect(Agile::CONFIG["remotes"].include?("new_remote")).to eq(true)
      end

      it "writes to config" do
        remote.add("new_remote")
        # some logic for this
      end

      it "successfully finishes" do
        remote.add("new_remote")
        expect(remote).to have_received(:say).with("Successfully added new remote!")
      end
    end

    describe "#list" do
      it "check for error" do
        remote.list
        expect(remote).to have_received(:error_checking_remotes)
      end

      it "shows all remotes" do
        remote.list
        expect(remote).to have_received(:say).exactly(Agile::CONFIG["remotes"].count).times
      end
    end
  end
end
