module QualtricsAPI
  class User < BaseModel
    values do
      attribute :id, String
      attribute :division_id, String
      attribute :username, String
      attribute :first_name, String
      attribute :last_name, String
      attribute :user_type, String
      attribute :email, String
      attribute :account_status, String
    end

    def messages(options = {})
      @messages ||= QualtricsAPI::LibraryMessageCollection.new(options.merge(id: id)).propagate_connection(self)
    end

    private

    def attributes_mappings
      {
        :id => "id",
        :division_id => "divisionId",
        :username => "username",
        :first_name => "firstName",
        :last_name => "lastName",
        :user_type => "userType",
        :email => "email",
        :account_status => "active"
      }
    end
  end
end
