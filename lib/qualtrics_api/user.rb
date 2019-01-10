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
      attribute :organization_id, String
      attribute :language, String
      attribute :unsubscribed, Boolean
      attribute :account_creation_date, String
      attribute :account_expiration_date, String
      attribute :password_last_changed_date, String
      attribute :password_expiration_date, String
      attribute :last_login_date, String
      attribute :timezone, String
      attribute :response_counts, Json
      attribute :permissions, Json
    end

    def message_collection(options = {})
      @message_collection ||= QualtricsAPI::LibraryMessageCollection.new(options.merge(id: id)).propagate_connection(self)
    end

    def messages
      @messages ||= message_collection.all
    end

    def get_message(id)
      message_collection.find(id)
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
        :account_status => "accountStatus",
        :organization_id  => "organizationId",
        :language  => "language",
        :unsubscribed => "unsubscribed",
        :account_creation_date => "accountCreationDate",
        :account_expiration_date => "accountExpirationDate",
        :password_last_changed_date => "passwordLastChangedDate",
        :password_expiration_date => "passwordExpirationDate",
        :last_login_date => "lastLoginDate",
        :timezone => "timezone",
        :response_counts => "responseCounts",
        :permissions => "permissions"
      }
    end
  end
end
