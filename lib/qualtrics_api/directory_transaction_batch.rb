module QualtricsAPI
  class DirectoryTransactionBatch < BaseModel
    values do
      attribute :id, String
      attribute :creation_date, String
      attribute :batch_id, String
    end

    private

    def attributes_mappings
      {
        id: "id",
        creation_date: "creationDate",
        batch_id: "batchId"
      }
    end
  end
end
