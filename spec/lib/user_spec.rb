require 'spec_helper'

describe QualtricsAPI::User do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
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
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    division_id: qualtrics_response["divisionId"],
    username: qualtrics_response["username"],
    first_name: qualtrics_response["firstName"],
    last_name: qualtrics_response["lastName"],
    user_type: qualtrics_response["userType"],
    email: qualtrics_response["email"],
    account_status: qualtrics_response["accountStatus"],
    organization_id: qualtrics_response["organizationId"],
    language: qualtrics_response["language"],
    unsubscribed: qualtrics_response["unsubscribed"],
    account_creation_date: qualtrics_response["accountCreationDate"],
    account_expiration_date: qualtrics_response["accountExpirationDate"],
    password_last_changed_date: qualtrics_response["passwordLastChangedDate"],
    password_expiration_date: qualtrics_response["passwordExpirationDate"],
    last_login_date: qualtrics_response["lastLoginDate"],
    timezone: qualtrics_response["timezone"],
    response_counts: qualtrics_response["responseCounts"],
    permissions: qualtrics_response["permissions"].deep_transform_keys { |key| key.underscore.to_sym })
  }
end
