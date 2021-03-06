module OData
  module Edm
    class DataServices
      cattr_accessor :schemas
      @@schemas = []

      attr_accessor :entity_types, :schemas
      
      def initialize(schemas = @@schemas)
        @entity_types = []
        @schemas = schemas.dup || []
        schemas.each do |schema|
          @entity_types.concat(schema.entity_types.values)
        end
      end

      def find_entity_type(name)
        @schemas.each do |schema|
          ret = schema.find_entity_type(name)
          return ret unless ret.nil?
        end
        nil
      end

      def to_json
        @entity_types.map do |entity|
          { name: entity.plural_name, kind: 'EntitySet', url: entity.plural_name }
        end
      end
    end
  end
end
