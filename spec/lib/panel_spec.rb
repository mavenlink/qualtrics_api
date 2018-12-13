require 'spec_helper'

describe QualtricsAPI::Panel do
  let(:qualtrics_response) do
    {
      "panelid" => "ML_bseUhQDwAJolD1j",
      "name" => "Master Panel",
      "libraryId" => "GR_2aaKA1aGidXQtOA",
      "category" => "Unassigned"
    }
  end

  subject { described_class.new qualtrics_response }

  it "has an panelId" do
    expect(subject.id).to eq qualtrics_response["panelId"]
  end

  it "has a name" do
    expect(subject.name).to eq qualtrics_response["name"]
  end

  it "has an libraryId" do
    expect(subject.library_id).to eq qualtrics_response["libraryId"]
  end

  it "has a category" do
    expect(subject.category).to eq qualtrics_response["category"]
  end

  describe "#members" do
    it "returns a PanelMemberCollection" do
      expect(subject.members).to be_a QualtricsAPI::PanelMemberCollection
    end

    it "assigns panel id" do
      expect(subject.members.id).to eq subject.id
    end

    it "caches the members" do
      expect(subject.members.object_id).to eq subject.members.object_id
    end
  end

  describe 'equality' do
    context 'when same' do
      it 'returns true' do
        expect(subject).to eq(described_class.new(subject.attributes))
      end
    end

    context 'when different' do
      it 'returns false' do
        expect(subject).not_to eq(described_class.new)
      end
    end
  end

  describe '#import_members' do
    it 'is delegated to the panel member collection' do
      collection_double = double()
      allow(subject).to receive(:members) { collection_double }
      expect(collection_double).to receive(:import_members).with([])
      subject.import_members([])
    end
  end

  describe '#create_member' do
    let(:member) { QualtricsAPI::PanelMember.new }
    it 'is delegated to the panel member collection' do
      collection_double = double()
      allow(subject).to receive(:members) { collection_double }
      expect(collection_double).to receive(:create).with(member)
      subject.create_member(member)
    end
  end

  describe "#create" do
    subject { described_class.new(request_attributes) }
    let(:request_attributes) { { "libraryId" => "1234", "name" => "Name", "category" => "Category" } }
    let(:connection_double) { instance_double(Faraday::Connection) }
    let(:panel_response) { instance_double(Faraday::Response, body: { "result" => { id: "9999", library_id: "1234", name: "Name", category: "Category" } }) }

    context "when successful" do
      before do
        allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
        allow(connection_double).to receive(:post) { panel_response }
      end

      it "calls the Qualtrics API with the correct payload attributes" do
        expect(connection_double).to receive(:post).with("mailinglists", request_attributes)
        subject.create
      end

      it "returns the Panel with response id" do
        expect(subject.create).to be_a QualtricsAPI::Panel
        expect(subject.create.id).to eq panel_response.body["result"]["id"]
      end
    end
  end
end
