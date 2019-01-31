require "spec_helper"

describe QualtricsAPI::DirectoryContactImport do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) { {
    "id" => "PGRS_abc123",
    "percentComplete" => "50.0",
    "contacts" => {
      "count" => {
        "added" => 1
      }
    },
    "tracking" => { "url" => "https://qualtrics.url/" },
    "status" => "in progress",
    "transactions" => {
      "count" => {
        "created" => 1
      }
    }
  } }

  it { is_expected.to have_attributes(
    id: qualtrics_response["id"],
    percent_complete: qualtrics_response["percentComplete"],
    contacts: qualtrics_response["contacts"].deep_transform_keys { |key| key.underscore.to_sym },
    tracking: qualtrics_response["tracking"].deep_transform_keys { |key| key.underscore.to_sym },
    status: qualtrics_response["status"],
    transactions: qualtrics_response["transactions"].deep_transform_keys { |key| key.underscore.to_sym }
  ) }
end
