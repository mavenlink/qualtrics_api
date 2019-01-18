module QualtricsAPI
  class Library < BaseModel


    def message_collection(options = {})
      @message_collection ||= QualtricsAPI::LibraryMessageCollection.new(options.merge(id: id)).propagate_connection(self)
    end

    def messages
      @messages ||= message_collection.all
    end
  end
end
