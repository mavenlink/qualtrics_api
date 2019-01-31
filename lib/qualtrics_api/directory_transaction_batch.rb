module QualtricsAPI
  class DirectoryTransactionBatch < BaseModel
    values do
      attribute :creation_date, String
      attribute :batch_id, String
    end

    private

    def attributes_mappings
      {
        creation_date: "creationDate",
        batch_id: "batchId"
      }
    end
  end
end
