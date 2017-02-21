require 'magic_models/version'
require 'magic_models/schema'

module MagicModels
  class << self
    def define
      schema = Schema::Define.new
      yield schema if block_given?
      schema.models.map(&:define)
    end

    def dump(&block)
      schema = Schema::Dump.new
      yield schema if block_given?
      schema.models.map(&:write)
    end
  end
end
