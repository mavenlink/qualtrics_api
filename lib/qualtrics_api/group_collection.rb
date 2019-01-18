module QualtricsAPI
  class GroupCollection < BaseCollection
    def [](group_id)
      find(group_id)
    end

    private

    def build_result(element)
      QualtricsAPI::Group.new(element)
    end

    def list_endpoint
      "groups"
    end

    def endpoint(id)
      "groups/#{id}"
    end
  end
end
