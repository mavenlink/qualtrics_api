module QualtricsAPI
  class DirectoryMailingListCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](mailing_list_id)
      find(mailing_list_id)
    end

    private

    def build_result(element)
      QualtricsAPI::DirectoryMailingList.new(element)
    end

    def list_endpoint
      "directories/#{id}/mailinglists"
    end

    def endpoint(mailing_list_id)
      "directories/#{id}/mailinglists/#{mailing_list_id}"
    end
  end
end
