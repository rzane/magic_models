require 'magic_models/model'

module MagicModels
  class Generator
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def models
      config.data_sources.map do |name|
        Model.new(config, name)
      end
    end

    def dump
      models.each do |model|
        File.open(model.filename, 'w') do |f|
          f.write model.render
        end
      end
    end

    def define
      models.map do |model|
        config.bind_to.eval(model.render)
        model.constantize
      end
    end
  end
end
