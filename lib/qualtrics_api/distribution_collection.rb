module QualtricsAPI
  class DistributionCollection < BaseCollection
    def find(id, survey_id)
      super(id, { "surveyId" => survey_id })
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
