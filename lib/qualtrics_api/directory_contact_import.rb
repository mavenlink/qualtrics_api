module QualtricsAPI
  class DirectoryContactImport < BaseModel
    values do
      attribute :id, String
      attribute :directory_id, String
      attribute :mailing_list_id, String
      attribute :percent_complete, Float
      attribute :contacts, Json
      attribute :tracking, Json
      attribute :status, String
      attribute :transactions, Json
    end

    def reload
      response = QualtricsAPI.connection(self).get(endpoint).body["result"]

      QualtricsAPI::DirectoryContactImport.new(response.merge(id: id, directory_id: directory_id, mailing_list_id: mailing_list_id)).propagate_connection(self)
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

    def endpoint
      "directories/#{directory_id}/mailinglists/#{mailing_list_id}/transactioncontacts/#{id}"
    end
  end
end
