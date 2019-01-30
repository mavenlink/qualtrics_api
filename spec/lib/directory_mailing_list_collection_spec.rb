require "spec_helper"

describe QualtricsAPI::DirectoryMailingListCollection do
  subject { described_class.new(id: directory_id) }
  let(:directory_id) { "UR_123abc" }
  let(:mailing_list_id) { "CG_000999" }
  let(:connection_double) { instance_double(Faraday::Connection) }
  let(:response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "contactCount" => 1,
      "creationDate" => 1489532997,
      "mailingListId" => mailing_list_id,
      "lastModifiedDate" => 1489532998,
      "name" => "example1"
    }
  } }

  it { is_expected.to have_attributes(id: directory_id) }

  describe "#find" do
    before do
      allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double}
      allow(connection_double).to receive(:get) { response }
    end

    it "calls get with the given id on the mailing list endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("directories/#{subject.id}/mailinglists/#{mailing_list_id}", {})
      subject.find(mailing_list_id)
    end

    context "when the response status is 200" do
      before do
        expect(response.status).to eq 200
      end

      it "returns the directory mailing list" do
        expect(subject.find(mailing_list_id)).to be_a QualtricsAPI::DirectoryMailingList
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(mailing_list_id)).to be_nil
      end
    end
  end
end
