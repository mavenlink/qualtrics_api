module QualtricsAPI
  class DirectoryMailingListCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](directory_mailing_list_id)
      find(directory_mailing_list_id)
    end

    def create_mailing_list(directory_mailing_list)
      response = QualtricsAPI.connection(self).post(list_endpoint, directory_mailing_list.create_attributes).body["result"]

      QualtricsAPI::DirectoryMailingList.new(directory_mailing_list.attributes.merge(id: response["id"])).propagate_connection(self)
    end

    private

    def build_result(element)
      QualtricsAPI::DirectoryMailingList.new(element)
    end

    def list_endpoint
      "directories/#{id}/mailinglists"
    end

    def endpoint(directory_mailing_list_id)
      "directories/#{id}/mailinglists/#{directory_mailing_list_id}"
    end
  end
end
