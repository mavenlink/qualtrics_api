module QualtricsAPI
  class DirectoryTransactionBatchCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](directory_transaction_batch_id)
      find(directory_transaction_batch_id)
    end

    def create_transaction_batch
      response = QualtricsAPI.connection(self).post(list_endpoint, {}).body["result"]

      QualtricsAPI::DirectoryTransactionBatch.new(id: response["id"]).propagate_connection(self)
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
