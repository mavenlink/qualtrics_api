require "spec_helper.rb"

describe QualtricsAPI::LibraryMessage do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
    "id" => "MS_aBcD1234",
    "description" => "A message!",
    "category" => "invite",
    "messages" => {
      "en" => "This is a message",
      "es" => "Este es un mensaje"
    }
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    description: qualtrics_response["description"],
    category: qualtrics_response["category"],
    messages: qualtrics_response["messages"])
  }
end
