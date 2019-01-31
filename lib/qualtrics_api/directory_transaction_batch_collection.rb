module QualtricsAPI
  class DirectoryTransactionBatchCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](directory_transaction_batch_id)
      find(directory_transaction_batch_id)
    end

    private

    def build_result(element)
      QualtricsAPI::DirectoryTransactionBatch.new(element)
    end

    def list_endpoint
      "directories/#{id}/transactionbatches"
    end

    def endpoint(directory_transaction_batch_id)
      "directories/#{id}/transactionbatches/#{directory_transaction_batch_id}"
    end
  end
end
