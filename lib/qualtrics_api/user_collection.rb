module QualtricsAPI
  class UserCollection < BaseCollection
    def [](user_id)
      find(user_id)
    end

    private

    def build_result(element)
      QualtricsAPI::User.new(element)
    end

    def list_endpoint
      'users'
    end

    def endpoint(id)
      "users/#{id}"
    end
  end
end
