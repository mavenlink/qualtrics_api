module QualtricsAPI
  class LibraryMessageCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](message_id)
      find(message_id)
    end

    private

    def build_result(element)
      QualtricsAPI::LibraryMessage.new(element)
    end

    def list_endpoint
      "libraries/#{id}/messages"
    end

    def endpoint(message_id)
      "libraries/#{id}/messages/#{message_id}"
    end
  end
end
