module QualtricsAPI
  class DirectoryCollection < BaseCollection
    def [](directory_id)
      raise QualtricsAPI::NotSupported, "#[] is not supported for Directory objects."
    end

    private

    def build_result(element)
      QualtricsAPI::Directory.new(element)
    end

    def list_endpoint
      "directories"
    end

    def endpoint(id)
      raise QualtricsAPI::NotSupported, "#find is not supported for Directory objects."
    end
  end
end
