require "spec_helper"

describe QualtricsAPI::DirectoryMailingList do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
    "id" => "CG_abc123",
    "mailingListId" => "CG_abc123",
    "name" => "Mailing List ABC",
    "ownerId" => "U_abc123",
    "lastModifiedDate" => 1548613610000,
    "creationDate" => 1548613610000,
    "contactCount" => 3
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    mailing_list_id: qualtrics_response["mailingListId"],
    name: qualtrics_response["name"],
    owner_id: qualtrics_response["ownerId"],
    last_modified_date: qualtrics_response["lastModifiedDate"],
    creation_date: qualtrics_response["creationDate"],
    contact_count: qualtrics_response["contactCount"])
  }

  describe "#create_attributes" do
    let(:create_attributes) { {
      "name"    => subject.name,
      "ownerId" => subject.owner_id
    } }

    it "returns only the correctly formatted attributes" do
      expect(subject.create_attributes).to eq create_attributes
    end
  end
end
