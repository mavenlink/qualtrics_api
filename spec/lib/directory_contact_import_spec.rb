require "spec_helper"

describe QualtricsAPI::DirectoryContactImport do
  subject { described_class.new qualtrics_response.merge(additional_attributes) }
  let(:additional_attributes) { { directory_id: "POOL_abc123", mailing_list_id: "CG_abc321" } }
  let(:qualtrics_response) { {
    "id" => "PGRS_abc123",
    "percentComplete" => "50.0",
    "contacts" => {
      "count" => {
        "added" => 1
      }
    },
    "tracking" => { "url" => "https://qualtrics.url/" },
    "status" => "in progress",
    "transactions" => {
      "count" => {
        "created" => 1
      }
    }
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    directory_id: additional_attributes[:directory_id],
    mailing_list_id: additional_attributes[:mailing_list_id],
    percent_complete: qualtrics_response["percentComplete"],
    contacts: qualtrics_response["contacts"].deep_transform_keys { |key| key.underscore.to_sym },
    tracking: qualtrics_response["tracking"].deep_transform_keys { |key| key.underscore.to_sym },
    status: qualtrics_response["status"],
    transactions: qualtrics_response["transactions"].deep_transform_keys { |key| key.underscore.to_sym }
  ) }

  describe "#reload" do
    let(:connection_double) { instance_double(Faraday::Connection) }
    let(:endpoint) { "directories/#{subject.directory_id}/mailinglists/#{subject.mailing_list_id}/transactioncontacts/#{subject.id}" }
    let(:response_double) { instance_double(Faraday::Response, body: response_body) }
    let(:response_body) { { "result" => qualtrics_response } }

    before do
      allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
      allow(connection_double).to receive(:get) { response_double }
    end

    it "calls get on the object" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with(endpoint)
      subject.reload
    end

    it "returns the directory contact import object" do
      expect(subject.reload).to be_a(QualtricsAPI::DirectoryContactImport)
    end
  end
end
