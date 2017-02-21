module MagicModels
  module Associations
    class BelongsTo
      attr_reader :foreign_key, :primary_key

      def initialize(foreign_key)
        @table_name = foreign_key.to_table
        @primary_key = foreign_key.options[:primary_key]
        @foreign_key = foreign_key.options[:column]
      end

      def name
        @foreign_key.sub(/_id$/, '').singularize
      end

      def macro
        'belongs_to'
      end

      def class_name
        @table_name.singularize.camelize
      end
    end
  end
end
