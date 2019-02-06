require "spec_helper"

describe QualtricsAPI::DirectoryTransactionBatchCollection do
  subject { described_class.new(id: directory_id) }
  let(:directory_id) { "POOL_123abc" }
  let(:directory_transaction_batch_id) { "BT_abc123" }
  let(:connection_double) { instance_double(Faraday::Connection) }
  let(:response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "creationDate" => "2019-01-01 12:12:12",
      "batchId" => directory_transaction_batch_id
    }
  } }

  before do
    allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
  end

  it { is_expected.to have_attributes(id: directory_id) }

  describe "#create_transaction_batch" do
    let(:response) { instance_double(Faraday::Response, body: response_body) }
    let(:response_body) { { "result" => { "id" => "BT_abc123" } } }

    context "when successful" do
      let(:new_directory_transaction_batch_double) { instance_double(QualtricsAPI::DirectoryTransactionBatch, id: response.body["result"]["id"]) }

      before do
        allow(connection_double).to receive(:post) { response }
        allow(QualtricsAPI::DirectoryTransactionBatch).to receive(:new) { new_directory_transaction_batch_double }
        allow(new_directory_transaction_batch_double).to receive(:propagate_connection) { new_directory_transaction_batch_double }
      end

      it "posts to the list endpoint with an empty body" do
        expect(connection_double).to receive(:post).with("directories/#{subject.id}/transactionbatches", {})
        subject.create_transaction_batch
      end

      it "returns the new directory transaction batch with the response id" do
        expect(QualtricsAPI::DirectoryTransactionBatch).to receive(:new).with(id: response.body["result"]["id"])
        expect(new_directory_transaction_batch_double).to receive(:propagate_connection).with(subject)
        expect(subject.create_transaction_batch).to be new_directory_transaction_batch_double
      end
    end
  end

  describe "#find" do
    before do
      allow(connection_double).to receive(:get) { response }
    end

    it "calls get with the given id on the transactionbatches endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("directories/#{subject.id}/transactionbatches/#{directory_transaction_batch_id}", {})
      subject.find(directory_transaction_batch_id)
    end

    context "when the response status is 200" do
      before do
        expect(response.status).to eq 200
      end

      it "returns the directory contact collection" do
        expect(subject.find(directory_transaction_batch_id)).to be_a QualtricsAPI::DirectoryTransactionBatch
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(directory_transaction_batch_id)).to be_nil
      end
    end
  end
end
