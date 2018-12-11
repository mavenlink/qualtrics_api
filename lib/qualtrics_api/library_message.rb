module QualtricsAPI
  class LibraryMessage < BaseModel
    values do
      attribute :id, String
      attribute :description, String
      attribute :category, String
    end

    private

    def attributes_mappings
      {
        :id => "id",
        :description => "description",
        :category => "category"
      }
    end
  end
end
