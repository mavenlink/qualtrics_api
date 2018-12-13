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
      payload  = self.attributes.transform_keys { |key| create_attributes[key] }.delete_if { |k, _v| k.nil? }
      response = QualtricsAPI.connection(self).post("mailinglists", payload).body["result"]

      return QualtricsAPI::Panel.new(self.attributes.merge(id: response["id"]))
    end

    private

    def create_attributes
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
