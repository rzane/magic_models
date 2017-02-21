require 'active_record'

module MagicModels
  class Configuration
    attr_accessor :bind_to, :connection, :destination

    delegate :primary_key, :foreign_keys, to: :connection

    def initialize
      @bind_to = TOPLEVEL_BINDING
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
  end
end
