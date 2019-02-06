module QualtricsAPI
  class DirectoryContactCollection < BaseCollection
    values do
      attribute :id, String
    end

    def [](directory_contact_id)
      find(directory_contact_id)
    end

    def import_contacts(directory_contacts, mailing_list_id, batch_id, transaction_fields)
      response = QualtricsAPI.connection(self).post(import_endpoint(mailing_list_id), directory_contacts_payload(directory_contacts, batch_id, transaction_fields)).body["result"]

      QualtricsAPI::DirectoryContactImport.new(id: response["id"], directory_id: id, mailing_list_id: mailing_list_id).propagate_connection(self)
    end

    private

    def directory_contacts_payload(directory_contacts, batch_id, transaction_fields)
      formatted_contacts = directory_contacts.map(&:import_attributes)

      payload = { "contacts" => formatted_contacts }
      payload.merge!("transactionMeta" => transaction_meta_payload(batch_id, transaction_fields)) if transaction_fields

      payload
    end

    def transaction_meta_payload(batch_id, transaction_fields)
      { "batchId" => batch_id, "fields" => transaction_fields }
    end

    def build_result(element)
      QualtricsAPI::DirectoryContact.new(element)
    end

    def list_endpoint
      "directories/#{id}/contacts"
    end

    def import_endpoint(mailing_list_id)
      "directories/#{id}/mailinglists/#{mailing_list_id}/transactioncontacts"
    end

    def endpoint(directory_contact_id)
      "directories/#{id}/contacts/#{directory_contact_id}"
    end
  end
end
