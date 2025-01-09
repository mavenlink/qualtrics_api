module QualtricsAPI
  class Client
    include QualtricsAPI::Connectable

    def initialize(api_token, data_center_id, custom_headers: {})
      @custom_headers = custom_headers
      @connection = establish_connection(api_token || fail('Please provide api token!'), data_center_id)
    end

    def surveys(options = {})
      QualtricsAPI::SurveyCollection.new(options).propagate_connection(self)
    end

    def response_exports(options = {})
      QualtricsAPI::ResponseExportCollection.new(options).propagate_connection(self)
    end

    def panels(options = {})
      QualtricsAPI::PanelCollection.new(options).propagate_connection(self)
    end

    def event_subscriptions(options = {})
      QualtricsAPI::EventSubscriptionCollection.new(options).propagate_connection(self)
    end

    def users(options = {})
      QualtricsAPI::UserCollection.new(options).propagate_connection(self)
    end

    def distributions(options = {})
      QualtricsAPI::DistributionCollection.new(options).propagate_connection(self)
    end

    def groups(options = {})
      QualtricsAPI::GroupCollection.new(options).propagate_connection(self)
    end

    def directories(options = {})
      QualtricsAPI::DirectoryCollection.new(options).propagate_connection(self)
    end

    private

    attr_reader :custom_headers

    def establish_connection(api_token, data_center_id)
      Faraday.new(url: QualtricsAPI.url(data_center_id), headers: { "X-API-TOKEN" => api_token }.merge(custom_headers)) do |faraday|
        faraday.request :multipart
        faraday.request :json

        faraday.response :json, :content_type => /\bjson$/
        faraday.response :follow_redirects

        faraday.use QualtricsAPI::RequestErrorHandler

        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
