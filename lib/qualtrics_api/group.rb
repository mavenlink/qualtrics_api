module QualtricsAPI
  class Group < Library
    values do
      attribute :id, String
      attribute :type, String
      attribute :division_id, String
      attribute :name, String
      attribute :auto_membership, Boolean
      attribute :creation_date, String
      attribute :creator_id, String
    end

    private

    def attributes_mappings
      {
        :id => "id",
        :type => "type",
        :division_id => "divisionId",
        :name => "name",
        :auto_membership => "autoMembership",
        :creation_date => "creationDate",
        :creator_id => "creatorId"
      }
    end
  end
end
