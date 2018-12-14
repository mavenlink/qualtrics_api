module QualtricsAPI
  class BaseCollection
    extend Forwardable
    include Enumerable
    include Virtus.value_object
    include QualtricsAPI::Extensions::SerializableCollection
    include QualtricsAPI::Extensions::VirtusAttributes
    include QualtricsAPI::Connectable

    def each
      each_page do |page|
        page.each do |element|
          yield element
        end
      end
    end

    def map
      res = []
      each_page do |page|
        page.each do |element|
          res.push(yield element)
        end
      end
      res
    end

    def filter(options = {})
      Array.new.tap do |result|
        each_page(options) do |page|
          page.each { |element| result.push(element) }
        end
      end
    end

    def all
      filter
    end

    def each_page(options = {})
      endpoint = list_endpoint

      loop do
        response = QualtricsAPI.connection(self).get(endpoint, camelize_keys(options))
        endpoint = response.body["result"]["nextPage"]
        yield parse_page(response)
        break unless endpoint
      end
    end

    def find(id, options = {})
      response = QualtricsAPI.connection(self).get(endpoint(id), camelize_keys(options))
      return nil unless response.status == 200
      build_result(response.body['result']).propagate_connection(self)
    end

    protected

    def page_endpoint(fetched)
      fetched ? @next_endpoint : list_endpoint
    end

    def parse_page(response)
      return [] unless response.body["result"]

      if response.body["result"]["elements"]
        response.body["result"]["elements"].map do |element|
          build_result(element).propagate_connection(self)
        end
      else
        Array.wrap(build_result(response.body["result"]).propagate_connection(self))
      end
    end

    def camelize_keys(hash)
      hash.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end
  end
end
