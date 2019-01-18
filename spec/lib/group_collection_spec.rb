require "spec_helper"

describe QualtricsAPI::GroupCollection do
  subject { described_class.new }
  let(:connection_double) { instance_double(Faraday::Connection) }
  let(:group_response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "id" => "UR_aBcD1234",
      "type" => "invite",
      "divisionId" => "D_abc123",
      "name" => "Group One",
      "autoMembership" => false,
      "creationDate" => "2019-01-01",
      "creatorId" => "U_abc123"
    }
  } }

  before do
    allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
    allow(connection_double).to receive(:get) { group_response }
  end

  describe "#find" do
    let(:group_id) { "G_aBcD1234" }

    it "calls get with the given id on the groups endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("groups/#{group_id}", {})
      subject.find(group_id)
    end

    context "when the response status is 200" do
      before do
        expect(group_response.status).to eq 200
      end

      it "returns the group" do
        expect(subject.find(group_id)).to be_a QualtricsAPI::Group
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(group_id)).to be_nil
      end
    end
  end
end
