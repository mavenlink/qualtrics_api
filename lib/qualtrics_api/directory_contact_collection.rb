module QualtricsAPI
  class DirectoryContactCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](directory_contact_id)
      find(directory_contact_id)
    end

    private

    def build_result(element)
      QualtricsAPI::DirectoryContact.new(element)
    end

    def list_endpoint
      "directories/#{id}/contacts"
    end

    def endpoint(directory_contact_id)
      "directories/#{id}/contacts/#{directory_contact_id}"
    end
  end
end
