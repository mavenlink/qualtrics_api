require "spec_helper"

describe QualtricsAPI::UserCollection do
  subject { described_class.new }
  let(:user_response) { instance_double(Faraday::Response, status: response_status, body: response_body) }
  let(:response_status) { 200 }
  let(:response_body) { {
    "result" => {
      "id" => "UR_aBcD1234",
      "username" => "somedude",
      "email" => "some@dude.com",
      "firstName" => "some",
      "lastName" => "dude",
      "userType" => "UT_BRANDADMIN",
      "organizationId" => "organization1",
      "divisionId" => "division1",
      "language" => "en",
      "accountStatus" => "active",
      "unsubscribed" => false,
      "accountCreationDate" => "2018-07-26T22:57:58Z",
      "accountExpirationDate" => "2019-07-26T22:57:58Z",
      "passwordLastChangedDate" => "2018-11-15T05:27:58Z",
      "passwordExpirationDate" => "2019-11-15T05:27:58Z",
      "lastLoginDate" => "2018-12-12T03:17:35Z",
      "timeZone" => "UTC-8",
      "responseCounts" => {
        "auditable" => 29,
        "generated" => 3,
        "deleted" => 0
      },
      "permissions" => {
        "controlPanel" => {
          "surveyPermissions" => {
            "useBlocks" => {
              "calculatedState" => "on"
            }
          }
        }
      }
    }
  } }

  describe "#find" do
    let(:connection_double) { instance_double(Faraday::Connection) }
    let(:user_id) { "UR_aBcD1234" }

    before do
      allow(QualtricsAPI).to receive(:connection).with(subject) { connection_double }
      allow(connection_double).to receive(:get) { user_response }
    end

    it "calls get with the given id on the users endpoint" do
      expect(QualtricsAPI).to receive(:connection).with(subject)
      expect(connection_double).to receive(:get).with("users/#{user_id}")
      subject.find(user_id)
    end

    context "when the response status is 200" do
      before do
        expect(user_response.status).to eq 200
      end

      it "returns the user" do
        expect(subject.find(user_id)).to be_a QualtricsAPI::User
      end
    end

    context "when the response status is not 200" do
      let(:response_status) { 404 }

      it "returns nil" do
        expect(subject.find(user_id)).to be_nil
      end
    end
  end
end
