require "spec_helper"

describe QualtricsAPI::DirectoryContact do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) do
    {
      "contactId" => "contact id",
      "creationDate" => 1223,
      "lastModified" => 9999999,
      "directoryUnsubscribed" => true,
      "directoryUnsubscribedDate" => "date",
      "firstName" => "Bob",
      "lastName" => "Bobbington",
      "email" => "bob@qualtrics.com",
      "emailDomain" => "qualtrics",
      "writeBlanks" => true,
      "phone" => "123-123-1234",
      "language" => "en",
      "extRef" => { "1" => "a", "2" => "b" },
      "embeddedData" => { "1" => "a", "2" => "b" },
      "stats" => { "1" => "a", "2" => "b" },
      "mailingListMembership" => { "1" => "a", "2" => "b" },
      "transactionData" => { "1" => "a", "2" => "b" }
    }
  end

  it { is_expected.to have_attributes(
    contact_id: qualtrics_response["contactId"],
    creation_date: qualtrics_response["creationDate"],
    last_modified: qualtrics_response["lastModified"],
    directory_unsubscribed: qualtrics_response["directoryUnsubscribed"],
    directory_unsubscribed_date: qualtrics_response["directoryUnsubscribedDate"],
    first_name: qualtrics_response["firstName"],
    last_name: qualtrics_response["lastName"],
    email: qualtrics_response["email"],
    email_domain: qualtrics_response["emailDomain"],
    write_blanks: qualtrics_response["writeBlanks"],
    phone: qualtrics_response["phone"],
    language: qualtrics_response["language"],
    external_reference: qualtrics_response["extRef"],
    embedded_data: qualtrics_response["embeddedData"],
    stats: qualtrics_response["stats"],
    mailing_list_membership: qualtrics_response["mailingListMembership"],
    transaction_data: qualtrics_response["transactionData"]
  ) }

  describe "#import_attributes" do
    let(:import_attributes) { {
      "directoryUnsubscribed" => qualtrics_response["directoryUnsubscribed"],
      "email" => qualtrics_response["email"],
      "embeddedData" => qualtrics_response["embeddedData"],
      "externalReference" => qualtrics_response["extRef"],
      "firstName" => qualtrics_response["firstName"],
      "language" => qualtrics_response["language"],
      "lastName" => qualtrics_response["lastName"],
      "transactionData" => qualtrics_response["transactionData"]
    } }

    it "returns only the correctly formatted attributes" do
      expect(subject.import_attributes).to eq import_attributes
    end
  end
end
