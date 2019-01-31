require "spec_helper"

describe QualtricsAPI::DirectoryTransactionBatch do
  subject { described_class.new qualtrics_response }
  let(:qualtrics_response) do
    {
      "creationDate" => "2019-01-31 00:04:11",
      "batchId" => "BT_1234599999"
    }
  end

  it { is_expected.to have_attributes(
    creation_date: qualtrics_response["creationDate"],
    batch_id: qualtrics_response["batchId"]
  ) }
end
