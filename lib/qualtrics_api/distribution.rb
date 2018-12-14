module QualtricsAPI
  class Distribution < BaseModel
    values do
      attribute :id, String
      attribute :parent_distribution_id, String
      attribute :owner_id, String
      attribute :organization_id, String
      attribute :request_status, String
      attribute :request_type, String
      attribute :send_date, String
      attribute :created_date, String
      attribute :modified_date, String
      attribute :headers, Json
      attribute :recipients, Json
      attribute :message, Json
      attribute :survey_link, Json
      attribute :embedded_data, Json
      attribute :stats, Json
    end

    def create
      response = QualtricsAPI.connection(self).post("distributions", create_attributes).body["result"]

      QualtricsAPI::Distribution.new(self.attributes.merge(id: response["id"]))
    end

    private

    def create_attributes
      attrs = self.attributes.compact.slice(*create_attributes_mappings.keys).merge(header: self.headers)
      attrs.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end

    def create_attributes_mappings
      {
        send_date: "sendDate",
        header: "header",
        recipients: "recipients",
        message: "message",
        survey_link: "surveyLink",
        embedded_data: "embeddedData"
      }
    end

    def attributes_mappings
      {
        id: "id",
        parent_distribution_id: "parentDistributionId",
        owner_id: "ownerId",
        organization_id: "organizationId",
        request_status: "requestStatus",
        request_type: "requestType",
        send_date: "sendDate",
        created_date: "createdDate",
        modified_date: "modifiedDate",
        headers: "headers",
        recipients: "recipients",
        message: "message",
        survey_link: "surveyLink",
        embedded_data: "embeddedData",
        stats: "stats"
      }
    end
  end
end
