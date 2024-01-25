module QualtricsAPI
  class Survey < BaseModel
    values do
      attribute :id, String
      attribute :name, String
      attribute :owner_id, String
      attribute :organization_id, String
      attribute :is_active, Boolean
      attribute :creation_date, String
      attribute :last_modified_date, String
      attribute :last_modified, String
      attribute :expiration, Json
      attribute :questions, Json
      attribute :export_column_map, Json
      attribute :blocks, Json
      attribute :flow, Array[Json]
      attribute :embedded_data, Array[Json]
      attribute :comments, Json
      attribute :loop_and_merge, Json
      attribute :response_counts, Json
    end

    def export_responses(export_options = {})
      QualtricsAPI::Services::ResponseExportService.new(**export_options.merge(survey_id: id)).propagate_connection(self)
    end

    private

    def attributes_mappings
      {
        :id => "id",
        :name => "name",
        :owner_id => "ownerId",
        :organization_id => "organizationId",
        :is_active => "isActive",
        :creation_date => "creationDate",
        :last_modified_date => "lastModifiedDate",
        :last_modified => "lastModified",
        :expiration => "expiration",
        :questions => "questions",
        :export_column_map => "exportColumnMap",
        :blocks => "blocks",
        :flow => "flow",
        :embedded_data => "embeddedData",
        :comments => "comments",
        :loop_and_merge => "loopAndMerge",
        :response_counts => "responseCounts"
      }
    end
  end
end
