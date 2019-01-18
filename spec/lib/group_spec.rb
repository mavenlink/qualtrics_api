require 'spec_helper'

describe QualtricsAPI::Group do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
    "id" => "UR_aBcD1234",
    "type" => "invite",
    "divisionId" => "D_abc123",
    "name" => "Group One",
    "autoMembership" => false,
    "creationDate" => "2019-01-01",
    "creatorId" => "U_abc123"
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    type: qualtrics_response["type"],
    division_id: qualtrics_response["divisionId"],
    name: qualtrics_response["name"],
    auto_membership: qualtrics_response["autoMembership"],
    creation_date: qualtrics_response["creationDate"],
    creator_id: qualtrics_response["creatorId"])
  }
end
