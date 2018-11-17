module QualtricsAPI
  module Extensions
    module VirtusAttributes
      class Json < Virtus::Attribute
        def coerce(value)
          value = JSON.parse(value) unless value.is_a? ::Hash

          value.deep_transform_keys { |key| key.underscore.to_sym }
        end
      end
    end
  end
end
