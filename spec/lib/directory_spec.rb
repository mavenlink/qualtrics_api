require "spec_helper"

describe QualtricsAPI::Directory do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
    "directoryId" => "POOL_abc123",
    "name" => "Directory 123",
    "contactCount" => 3,
    "isDefault" => true
  } }

  it { is_expected.to have_attributes(
    directory_id: qualtrics_response["directoryId"],
    name: qualtrics_response["name"],
    contact_count: qualtrics_response["contactCount"],
    is_default: qualtrics_response["isDefault"])
  }
end
