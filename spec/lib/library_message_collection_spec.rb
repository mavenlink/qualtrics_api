require "spec_helper"

describe QualtricsAPI::LibraryMessageCollection do
  subject { described_class.new(id: library_id) }
  let(:library_id) { "UR_aBcD1234" }
  let(:message_response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "id" => "MS_aBcD1234",
      "description" => "A message!",
      "category" => "invite",
      "messages" => {
        "en" => "This is a message",
        "es" => "Este es un mensaje"
      }
    }
  } }

  it { is_expected.to have_attributes(id: library_id) }

  describe "#find" do
    let(:connection_double) { instance_double(Faraday::Connection) }
    let(:message_id) { "MS_aBcD1234" }

    before do
      allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
      allow(connection_double).to receive(:get) { message_response }
    end

    it "calls get with the given id on the users endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("libraries/#{subject.id}/messages/#{message_id}")
      subject.find(message_id)
    end

    context "when the response status is 200" do
      before do
        expect(message_response.status).to eq 200
      end

      it "returns the user" do
        expect(subject.find(message_id)).to be_a QualtricsAPI::LibraryMessage
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(message_id)).to be_nil
      end
    end
  end
end
