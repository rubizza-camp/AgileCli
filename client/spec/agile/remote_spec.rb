RSpec.describe Agile::Remotes do
  subject(:remote) { described_class.new }

  before do
    Agile::CONFIG["remotes"].clear
    Agile::CONFIG["current_user"] = "smone"
    allow(remote).to receive(:error_checking_remotes)
    allow(remote).to receive(:say)
  end

  describe "#use" do
    it "check for error" do
      remote.use("remote")
      expect(remote).to have_received(:error_checking_remotes)
    end

    it "aborts when remote wasn't added" do
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
      expect(File.exist?("#{Agile::GEM_PATH}/.config.json")).to eq(true)
    end

    it "successfully finishes" do
      Agile::CONFIG["remotes"] << "remote"
      remote.use("remote")
      expect(remote).to have_received(:say).with("Successfully changed current remote!")
    end
  end
end

RSpec.describe Agile::Remotes do
  subject(:remote) { described_class.new }

  before do
    Agile::CONFIG["remotes"].clear
    Agile::CONFIG["current_user"] = "smone"
    allow(remote).to receive(:error_checking_remotes)
    allow(remote).to receive(:say)
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
      expect(File.exist?("#{Agile::GEM_PATH}/.config.json")).to eq(true)
    end

    it "successfully finishes" do
      remote.add("new_remote")
      expect(remote).to have_received(:say).with("Successfully added new remote!")
    end
  end
end

RSpec.describe Agile::Remotes do
  subject(:remote) { described_class.new }

  before do
    Agile::CONFIG["current_user"] = "smone"
    allow(remote).to receive(:error_checking_remotes)
    allow(remote).to receive(:say)
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
