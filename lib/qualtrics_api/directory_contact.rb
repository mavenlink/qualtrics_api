module QualtricsAPI
  class DirectoryContact < BaseModel
    values do
      attribute :contact_id, String
      attribute :creation_date, Integer
      attribute :last_modified, Integer
      attribute :directory_unsubscribed, Boolean
      attribute :directory_unsubscribed_date, String
      attribute :first_name, String
      attribute :last_name, String
      attribute :email, String
      attribute :email_domain, String
      attribute :write_blanks, Boolean
      attribute :phone, String
      attribute :language, String
      attribute :external_reference, String
      attribute :embedded_data, Json
      attribute :stats, Json
      attribute :mailing_list_membership, Json
      attribute :transaction_data, Json
    end

    def import_attributes
      attrs = self.attributes.compact.slice(*import_attributes_mappings.keys)
      attrs.transform_keys { |key| import_attributes_mappings[key] }
    end

    private

    def import_attributes_mappings
      {
        first_name: "firstName",
        last_name: "lastName",
        email: "email",
        language: "language",
        embedded_data: "embeddedData",
        external_reference: "extRef",
        transaction_data: "transactionData",
        directory_unsubscribed: "unsubscribed"
      }
    end

    def attributes_mappings
      {
        contact_id: "contactId",
        creation_date: "creationDate",
        last_modified: "lastModified",
        directory_unsubscribed: "directoryUnsubscribed",
        directory_unsubscribed_date: "directoryUnsubscribedDate",
        first_name: "firstName",
        last_name: "lastName",
        email: "email",
        email_domain: "emailDomain",
        write_blanks: "writeBlanks",
        phone: "phone",
        language: "language",
        external_reference: "extRef",
        embedded_data: "embeddedData",
        stats: "stats",
        mailing_list_membership: "mailingListMembership",
        transaction_data: "transactionData"
      }
    end
  end
end
