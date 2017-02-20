require 'magic_models/version'
require 'magic_models/configuration'
require 'magic_models/generator'

module MagicModels
  class << self
    def define(&block)
      conceptualize(&block).define
    end

    def dump(&block)
      conceptualize(&block).dump
    end

    private

    def conceptualize
      config = Configuration.new
      yield config if block_given?
      Generator.new(config)
    end
  end
end

