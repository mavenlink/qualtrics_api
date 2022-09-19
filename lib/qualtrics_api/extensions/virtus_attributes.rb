module QualtricsAPI
  module Extensions
    module VirtusAttributes
      class Json < Virtus::Attribute
        def coerce(value)
          return value if value.blank?
          return value.with_indifferent_access if value.is_a?(::Hash)

          JSON.parse(value).with_indifferent_access
        end
      end
    end
  end
end
