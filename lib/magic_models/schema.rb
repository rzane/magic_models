require 'active_record'
require 'magic_models/model'

module MagicModels
  module Schema
    class Base
      attr_reader :appends
      attr_accessor :base_class, :connection
      delegate :primary_key, :foreign_keys, to: :connection

      def initialize
        @base_class = 'ActiveRecord::Base'
        @connection = ActiveRecord::Base.connection
        @exclude = ['schema_migrations', 'ar_internal_metadata']
        @appends = Hash.new do |hsh, key|
          hsh[key] = []
        end
      end

      def exclude(*tables)
        @exclude += tables.flatten
      end

      def append(table_name, content)
        appends[table_name] << content
      end

      def data_sources
        connection.data_sources - @exclude
      end

      def models
        data_sources.map do |name|
          Model.new(self, name)
        end
      end
    end

    class Define < Base
      attr_accessor :namespace

      def evaluate(*args, &block)
        if namespace
          namespace.module_eval(*args, &block)
        else
          TOPLEVEL_BINDING.eval(*args, &block)
        end
      end
    end

    class Dump < Base
      attr_accessor :destination

      def initialize
        super
        @destination = File.join(Dir.pwd, 'app', 'models')
      end
    end
  end
end
