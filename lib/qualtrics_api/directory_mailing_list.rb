module QualtricsAPI
  class DirectoryMailingList < BaseModel
    values do
      attribute :mailing_list_id, String
      attribute :name, String
      attribute :owner_id, String
      attribute :last_modified_date, Integer  # 13-digit UNIX time
      attribute :creation_date, Integer       # 13-digit UNIX time
      attribute :contact_count, Integer
    end

    private

    def attributes_mappings
      {
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
