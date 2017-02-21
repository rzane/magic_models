require 'active_record'

module MagicModels
  class Configuration
    attr_accessor :base_class, :namespace, :connection, :destination

    delegate :primary_key, :foreign_keys, to: :connection

    def initialize
      @base_class = 'ActiveRecord::Base'
      @connection = ActiveRecord::Base.connection
      @destination = File.join(Dir.pwd, 'app', 'models')
      @exclude = ['schema_migrations', 'ar_internal_metadata']
    end

    def exclude(*tables)
      @exclude += tables.flatten
    end

    def data_sources
      connection.data_sources - @exclude
    end

    def evaluate(*args, &block)
      if namespace
        namespace.module_eval(*args, &block)
      else
        TOPLEVEL_BINDING.eval(*args, &block)
      end
    end
  end
end
