require 'spec_helper'

describe QualtricsAPI::Library do
  subject { described_class.new }
  let(:collection_double) { instance_double(QualtricsAPI::LibraryMessageCollection) }

  before do
    allow(subject).to receive(:id) { "some_id" }
    allow(QualtricsAPI::LibraryMessageCollection).to receive(:new) { collection_double }
    allow(collection_double).to receive(:propagate_connection) { collection_double }
  end

  describe "#message_collection" do
    it "creates a LibraryMessageCollection with the same connection" do
      expect(QualtricsAPI::LibraryMessageCollection).to receive(:new).with(id: subject.id)
      expect(collection_double).to receive(:propagate_connection).with(subject)
      expect(subject.message_collection).to be collection_double
    end
  end

  describe "#messages" do
    it "gets all messages for the user" do
      expect(collection_double).to receive(:all)
      subject.messages
    end
  end
end
