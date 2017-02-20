require 'active_record'

module MagicModels
  class Configuration
    attr_accessor :bind_to, :connection, :destination

    delegate :data_sources, to: :connection

    def initialize
      @exclude = []
      @bind_to = TOPLEVEL_BINDING
      @connection = ActiveRecord::Base.connection
      @destination = File.join(Dir.pwd, 'app', 'models')
    end

    def exclude(*tables)
      @exclude += tables.flatten
    end

    def data_sources
      connection.data_sources - @exclude
    end
  end
end
