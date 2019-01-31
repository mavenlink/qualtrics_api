module QualtricsAPI
  class DirectoryMailingList < BaseModel
    values do
      attribute :id, String
      attribute :mailing_list_id, String
      attribute :name, String
      attribute :owner_id, String
      attribute :last_modified_date, Integer  # 13-digit UNIX time
      attribute :creation_date, Integer       # 13-digit UNIX time
      attribute :contact_count, Integer
    end

    def create_attributes
      attrs = self.attributes.compact.slice(*create_attributes_mappings.keys)
      attrs.transform_keys { |key| create_attributes_mappings[key] }
    end

    private

    def create_attributes_mappings
      {
        name: "name",
        owner_id: "ownerId"
      }
    end

    def attributes_mappings
      {
        id: "id",
        mailing_list_id: "mailingListId",
        name: "name",
        owner_id: "ownerId",
        last_modified_date: "lastModifiedDate",
        creation_date: "creationDate",
        contact_count: "contactCount"
      }
    end
  end
end
