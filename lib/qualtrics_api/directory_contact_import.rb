module QualtricsAPI
  class DirectoryContactImport < BaseModel
    values do
      attribute :id, String
      attribute :percent_complete, Float
      attribute :contacts, Json
      attribute :tracking, Json
      attribute :status, String
      attribute :transactions, Json
    end

    private

    def attributes_mappings
      {
        id: "id",
        percent_complete: "percentComplete",
        contacts: "contacts",
        tracking: "tracking",
        status: "status",
        transactions: "transactions"
      }
    end
  end
end
