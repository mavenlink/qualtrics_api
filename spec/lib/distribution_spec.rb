require "spec_helper"

describe QualtricsAPI::Distribution do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
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
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    parent_distribution_id: qualtrics_response["parentDistributionId"],
    owner_id: qualtrics_response["ownerId"],
    organization_id: qualtrics_response["organizationId"],
    request_status: qualtrics_response["requestStatus"],
    request_type: qualtrics_response["requestType"],
    send_date: qualtrics_response["sendDate"],
    created_date: qualtrics_response["createdDate"],
    modified_date: qualtrics_response["modifiedDate"],
    headers: qualtrics_response["headers"].deep_transform_keys { |key| key.underscore.to_sym },
    recipients: qualtrics_response["recipients"].deep_transform_keys { |key| key.underscore.to_sym },
    message: qualtrics_response["message"].deep_transform_keys { |key| key.underscore.to_sym },
    survey_link: qualtrics_response["surveyLink"],
    embedded_data: qualtrics_response["embeddedData"],
    stats: qualtrics_response["stats"])
  }

  describe "#create" do
    let(:request_attributes) { {
      "sendDate" => "2014-02-18T22:57:04Z",
      "header" => {
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
      }
    } }
    let(:connection_double) { instance_double(Faraday::Connection) }
    let(:distribution_response) { instance_double(Faraday::Response, body: distribution_response_body) }
    let(:distribution_response_body) { { "result" => request_attributes.merge("id" => "EMD_abc123") } }

    context "when successful" do
      before do
        allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
        allow(connection_double).to receive(:post) { distribution_response }
      end

      it "calls the Qualtrics API with the correct payload attributes" do
        expect(connection_double).to receive(:post).with("distributions", request_attributes)
        subject.create
      end

      it "returns the Panel with response id" do
        saved_subject = subject.create
        expect(saved_subject).to be_a QualtricsAPI::Distribution
        expect(saved_subject.id).to eq distribution_response.body["result"]["id"]
      end
    end
  end
end
