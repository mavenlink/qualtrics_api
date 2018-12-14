require "spec_helper"

describe QualtricsAPI::DistributionCollection do
  subject { described_class.new }
  let(:connection_double) { instance_double(Faraday::Connection) }
  let(:distribution_response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "id" => "EMD_abc123",
      "parentDistributionId" => "EMD_parent",
      "ownerId" => "UR_abc123",
      "organizationId" => "apitest",
      "requestStatus" => "Done",
      "requestType" => "Invite",
      "sendDate" => "2014-02-18T22:57:04Z",
      "createdDate" => "2014-02-18T22:57:04Z",
      "modifiedDate" => "2014-02-19T22:57:04Z",
      "headers" => {
        "fromEmail" => "apitest@qualtrics.com",
        "replyToEmail" => "apitest@qualtrics.com",
        "fromName" => "Api Test",
        "subject" => "flow test"
      },
      "recipients" => {
        "mailingListId" => "ML_abc123",
        "contactId" => "C_abc123",
        "libraryId" => "UR_abc123",
        "sampleId" => "S_abc123"
      },
      "message" => {
        "libraryId" => "UR_abc123",
        "messageId" => "MS_abc123",
        "messageText" => "This is a message"
      },
      "surveyLink" => {
        "surveyId" => "SV_abc123",
        "expirationDate" => "2014-04-19T21:57:04Z",
        "linkType" => "Individual"
      },
      "embeddedData" => {
        "emailAuthor" => "bob",
        "emailType" => "leading question"
      },
      "stats" => {
        "sent" => 2,
        "failed" => 0,
        "started" => 2,
        "bounced" => 0,
        "opened" => 2,
        "skipped" => 0,
        "finished" => 2,
        "complaints" => 0,
        "blocked" => 0
      }
    }
  } }

  before do
    allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
    allow(connection_double).to receive(:get) { distribution_response }
  end

  describe "#find" do
    let(:connection_double) { instance_double(Faraday::Connection) }
    let(:distribution_id) { "EMD_abc123" }
    let(:survey_id) { "SV_abc123" }

    it "calls get with the given id on the users endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("distributions/#{distribution_id}", { "surveyId" => survey_id })
      subject.find(distribution_id, survey_id)
    end

    context "when the response status is 200" do
      before do
        expect(distribution_response.status).to eq 200
      end

      it "returns the user" do
        expect(subject.find(distribution_id, survey_id)).to be_a QualtricsAPI::Distribution
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(distribution_id, survey_id)).to be_nil
      end
    end
  end

  describe "#filter" do
    let(:filters) { { "surveyId" => "SV_abc123" } }

    it "calls get with the given options on the users endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("distributions", filters)
      subject.filter(filters)
    end

    it "returns the result array of filtered objects" do
      expect(subject.filter(filters)).to include a_kind_of QualtricsAPI::Distribution
    end
  end
end
