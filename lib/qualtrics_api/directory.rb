module QualtricsAPI
  class Directory < BaseModel
    values do
      attribute :directory_id, String
      attribute :name, String
      attribute :contact_count, Integer
      attribute :is_default, Boolean
    end

    def mailing_lists
      mailing_list_collection.all
    end

    def create_mailing_list(directory_mailing_list)
      mailing_list_collection.create_mailing_list(directory_mailing_list)
    end

    def transaction_batches
      transaction_batch_collection.all
    end

    def create_transaction_batch
      transaction_batch_collection.create_transaction_batch
    end

    def contacts
      contact_collection.all
    end

    def import_contacts(directory_contacts, mailing_list_id, batch_id = nil, transaction_fields = nil)
      contact_collection.import_contacts(directory_contacts, mailing_list_id, batch_id, transaction_fields)
    end

    private

    def mailing_list_collection(options = {})
      @mailing_list_collection ||= QualtricsAPI::DirectoryMailingListCollection.new(**options.merge(id: directory_id)).propagate_connection(self)
    end

    def transaction_batch_collection(options = {})
      @transaction_batch_collection ||= QualtricsAPI::DirectoryTransactionBatchCollection.new(**options.merge(id: directory_id)).propagate_connection(self)
    end

    def contact_collection(options = {})
      @contact_collection ||= QualtricsAPI::DirectoryContactCollection.new(**options.merge(id: directory_id)).propagate_connection(self)
    end

    def attributes_mappings
      {
        directory_id: "directoryId",
        name: "name",
        contact_count: "contactCount",
        is_default: "isDefault"
      }
    end
  end
end
