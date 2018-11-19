module QualtricsAPI
  module Extensions
    module VirtusAttributes
      class Json < Virtus::Attribute
        def coerce(value)
          return value unless value.present?

          value = JSON.parse(value) unless value.is_a? ::Hash

          value.deep_transform_keys do |key|
            key.upcase == key ? key.to_sym : key.underscore.to_sym
          end.with_indifferent_access
        end
      end
    end
  end
end
