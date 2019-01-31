module QualtricsAPI
  class DirectoryMailingListCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](directory_mailing_list_id)
      find(directory_mailing_list_id)
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
