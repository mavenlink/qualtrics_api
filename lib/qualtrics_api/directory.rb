module QualtricsAPI
  class Directory < BaseModel
    values do
      attribute :directory_id, String
      attribute :name, String
      attribute :contact_count, Integer
      attribute :is_default, Boolean
    end

    private

    def attributes_mappings
      {
        directory_id: "directoryId",
        name: "name",
        contact_count: "contactCount",
        is_default: "isDefault"
      }
    end
  end
end
