require "spec_helper"

describe QualtricsAPI::Directory do
  subject { described_class.new qualtrics_response }
  let(:directory_mailing_list_collection_double) { instance_double(QualtricsAPI::DirectoryMailingListCollection) }
  let(:directory_transaction_batch_collection_double) { instance_double(QualtricsAPI::DirectoryTransactionBatchCollection) }
  let(:directory_contact_collection_double) { instance_double(QualtricsAPI::DirectoryContactCollection) }
  let(:qualtrics_response) { {
    "directoryId" => "POOL_abc123",
    "name" => "Directory 123",
    "contactCount" => 3,
    "isDefault" => true
  } }

  before do
    allow(QualtricsAPI::DirectoryMailingListCollection).to receive(:new) { directory_mailing_list_collection_double }
    allow(QualtricsAPI::DirectoryTransactionBatchCollection).to receive(:new) { directory_transaction_batch_collection_double }
    allow(QualtricsAPI::DirectoryContactCollection).to receive(:new) { directory_contact_collection_double }
    allow(directory_mailing_list_collection_double).to receive(:propagate_connection) { directory_mailing_list_collection_double }
    allow(directory_transaction_batch_collection_double).to receive(:propagate_connection) { directory_transaction_batch_collection_double }
    allow(directory_contact_collection_double).to receive(:propagate_connection) { directory_contact_collection_double }
  end

  it { is_expected.to have_attributes(
    directory_id: qualtrics_response["directoryId"],
    name: qualtrics_response["name"],
    contact_count: qualtrics_response["contactCount"],
    is_default: qualtrics_response["isDefault"]
  ) }

  describe "#mailing_lists" do
    before do
      allow(directory_mailing_list_collection_double).to receive(:all)
    end

    after do
      subject.mailing_lists
    end

    it "creates a DirectoryMailingListCollection with the same connection" do
      expect(QualtricsAPI::DirectoryMailingListCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_mailing_list_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls all on the directory mailing list collection" do
      expect(directory_mailing_list_collection_double).to receive(:all)
    end
  end

  describe "#create_mailing_list" do
    let(:directory_mailing_list_double) { instance_double(QualtricsAPI::DirectoryMailingList) }

    before do
      allow(directory_mailing_list_collection_double).to receive(:create_mailing_list)
    end

    after do
      subject.create_mailing_list(directory_mailing_list_double)
    end

    it "creates a DirectoryMailingListCollection with the same connection" do
      expect(QualtricsAPI::DirectoryMailingListCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_mailing_list_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls create on the directory mailing list collection with the given directory mailing list" do
      expect(directory_mailing_list_collection_double).to receive(:create_mailing_list).with(directory_mailing_list_double)
    end
  end

  describe "#transaction_batches" do
    before do
      allow(directory_transaction_batch_collection_double).to receive(:all)
    end

    after do
      subject.transaction_batches
    end

    it "creates a DirectoryTransactionBatchCollection with the same connection" do
      expect(QualtricsAPI::DirectoryTransactionBatchCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_transaction_batch_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls all on the directory transaction batch collection" do
      expect(directory_transaction_batch_collection_double).to receive(:all)
    end
  end

  describe "#create_transaction_batch" do
    before do
      allow(directory_transaction_batch_collection_double).to receive(:create_transaction_batch)
    end

    after do
      subject.create_transaction_batch
    end

    it "creates a DirectoryTransactionBatchCollection with the same connection" do
      expect(QualtricsAPI::DirectoryTransactionBatchCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_transaction_batch_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls create on the directory transaction batch collection with the given directory transaction batch" do
      expect(directory_transaction_batch_collection_double).to receive(:create_transaction_batch)
    end
  end

  describe "#contacts" do
    before do
      allow(directory_contact_collection_double).to receive(:all)
    end

    after do
      subject.contacts
    end

    it "creates a DirectoryContactCollection with the same connection" do
      expect(QualtricsAPI::DirectoryContactCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_contact_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls all on the directory contact collection" do
      expect(directory_contact_collection_double).to receive(:all)
    end
  end

  describe "#import_contacts" do
    let(:mailing_list_id) { "CG_abc123" }
    let(:directory_contacts) { [instance_double(QualtricsAPI::DirectoryContact)] }
    let(:batch_id) { "BT_abc123" }
    let(:transaction_fields) { [] }

    before do
      allow(directory_contact_collection_double).to receive(:import_contacts)
    end

    after do
      subject.import_contacts(mailing_list_id, directory_contacts, batch_id, transaction_fields)
    end

    it "creates a DirectoryContactCollection with the same connection" do
      expect(QualtricsAPI::DirectoryContactCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_contact_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls import_contacts on the directory contact collection" do
      expect(directory_contact_collection_double).to receive(:import_contacts).with(mailing_list_id, directory_contacts, batch_id, transaction_fields)
    end
  end
end
