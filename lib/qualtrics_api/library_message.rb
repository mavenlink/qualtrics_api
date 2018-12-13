module QualtricsAPI
  class LibraryMessage < BaseModel
    values do
      attribute :id, String
      attribute :description, String
      attribute :category, String
      attribute :messages, Json
    end

    private

    def attributes_mappings
      {
        :id => "id",
        :description => "description",
        :category => "category",
        :messages => "messages"
      }
    end
  end
end
