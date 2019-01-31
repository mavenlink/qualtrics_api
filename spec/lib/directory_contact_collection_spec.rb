require "spec_helper"

describe QualtricsAPI::DirectoryContactCollection do
  subject { described_class.new(id: directory_id) }
  let(:directory_id) { "UR_123abc" }
  let(:directory_contact_id) { "CG_239485" }
  let(:connection_double) { instance_double(Faraday::Connection) }
  let(:response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "contactId": "CID_04934059834",
      "creationDate": 1547332513000,
      "lastModified": 1547332513000,
      "firstName": "",
      "lastName": "",
      "email": "bobbyQ@qualtrics.com",
      "emailDomain": "qualtrics.com",
      "phone": "123-456-1234",
      "language": "en",
      "writeBlanks": false,
      "extRef": "",
      "embeddedData": {},
      "transactionData": [],
      "stats": {},
      "skipped": false,
      "directoryUnsubscribed": false,
      "directoryUnsubscribeDate": 1547332513000,
      "mailingListMembership": {}
    }
  } }

  it { is_expected.to have_attributes(id: directory_id) }

  describe "#find" do
    before do
      allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
      allow(connection_double).to receive(:get) { response }
    end

    it "calls get with the given id on the contact endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("directories/#{subject.id}/contacts/#{directory_contact_id}", {})
      subject.find(directory_contact_id)
    end

    context "when the response status is 200" do
      before do
        expect(response.status).to eq 200
      end

      it "returns the directory contact collection" do
        expect(subject.find(directory_contact_id)).to be_a QualtricsAPI::DirectoryContact
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(directory_contact_id)).to be_nil
      end
    end
  end
end
