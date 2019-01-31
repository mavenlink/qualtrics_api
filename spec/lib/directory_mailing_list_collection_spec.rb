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

  before do
    allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
  end

  it { is_expected.to have_attributes(id: directory_id) }

  describe "#create_mailing_list" do
    let(:directory_mailing_list_double) { instance_double(QualtricsAPI::DirectoryMailingList, directory_mailing_list_attributes) }
    let(:directory_mailing_list_attributes) { { name: "Mailing List 1", owner_id: "GR_abc123" } }
    let(:request_attributes) { { "name" => "Mailing List 1", "ownerId" => "GR_abc123" } }
    let(:response) { instance_double(Faraday::Response, body: response_body) }
    let(:response_body) { { "result" => request_attributes.merge("id" => "CG_abc123") } }

    context "when successful" do
      let(:new_directory_mailing_list_double) { instance_double(QualtricsAPI::DirectoryMailingList, new_directory_mailing_list_attributes) }
      let(:new_directory_mailing_list_attributes) { directory_mailing_list_attributes.merge(id: response.body["result"]["id"]) }

      before do
        allow(connection_double).to receive(:post) { response }
        allow(QualtricsAPI::DirectoryMailingList).to receive(:new) { new_directory_mailing_list_double }
        allow(directory_mailing_list_double).to receive(:create_attributes) { request_attributes }
        allow(directory_mailing_list_double).to receive(:attributes) { directory_mailing_list_attributes }
        allow(new_directory_mailing_list_double).to receive(:propagate_connection) { new_directory_mailing_list_double }
      end

      it "posts to the list endpoint with the correct attributes" do
        expect(connection_double).to receive(:post).with("directories/#{subject.id}/mailinglists", request_attributes)
        subject.create_mailing_list(directory_mailing_list_double)
      end

      it "returns the new directory mailing list with the response id" do
        expect(QualtricsAPI::DirectoryMailingList).to receive(:new).with(new_directory_mailing_list_attributes)
        expect(new_directory_mailing_list_double).to receive(:propagate_connection).with(subject)
        expect(subject.create_mailing_list(directory_mailing_list_double)).to be new_directory_mailing_list_double
      end
    end
  end

  describe "#find" do
    before do
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
