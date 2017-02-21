module MagicModels
  module Associations
    class Base
      attr_reader :foreign_key, :primary_key

      def macro
        self.class.name.demodulize.underscore
      end

      def class_name
        @table_name.singularize.camelize
      end
    end

    class BelongsTo < Base
      def initialize(foreign_key)
        @table_name = foreign_key.to_table
        @primary_key = foreign_key.options[:primary_key]
        @foreign_key = foreign_key.options[:column]
      end

      def name
        @foreign_key.sub(/_id$/, '').singularize
      end
    end

    class HasOne < Base
      def initialize(foreign_key)
        @table_name  = foreign_key.from_table
        @primary_key = foreign_key.options[:column]
        @foreign_key = foreign_key.options[:primary_key]
      end

      def name
        @primary_key.sub(/_id$/, '').singularize
      end
    end

    class HasMany < HasOne
      def name
        super.pluralize
      end
    end
  end
end
