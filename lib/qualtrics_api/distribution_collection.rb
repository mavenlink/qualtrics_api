module QualtricsAPI
  class DistributionCollection < BaseCollection
    def find(id, options = {})
      if camelize_keys(options)["surveyId"].nil?
        raise ArgumentError.new("`surveyId` must be included when finding a distribution")
      end

      super
    end

    private

    def build_result(element)
      QualtricsAPI::Distribution.new(element)
    end

    def list_endpoint
      "distributions"
    end

    def endpoint(distribution_id)
      "distributions/#{distribution_id}"
    end
  end
end
