module QualtricsAPI
  class Panel < BaseModel
    values do
      attribute :id, String
      attribute :library_id, String
      attribute :name, String
      attribute :category, String
      attribute :folder, String
    end

    def members(options = {})
      @members ||= QualtricsAPI::PanelMemberCollection.new(options.merge(id: id)).propagate_connection(self)
    end

    def import_members(mbs)
      members.import_members(mbs)
    end

    def create_member(member)
      members.create(member)
    end

    def create
      payload  = create_attributes.transform_keys { |key| create_attributes_mappings[key] }
      response = QualtricsAPI.connection(self).post("mailinglists", payload).body["result"]

      QualtricsAPI::Panel.new(self.attributes.merge(id: response["id"])).propagate_connection(self)
    end

    private

    def create_attributes
      self.attributes.compact.slice(*create_attributes_mappings.keys)
    end

    def create_attributes_mappings
      {
        :library_id => "libraryId",
        :name => "name",
        :category => "category"
      }
    end

    def attributes_mappings
      {
        :id => "id",
        :library_id => "libraryId",
        :name => "name",
        :category => "category",
        :folder => "folder"
      }
    end
  end
end
