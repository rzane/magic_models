require 'erb'

module MagicModels
  class Model
    attr_reader :config, :name

    def initialize(config, name)
      @config = config
      @name   = name
    end

    def filename
      File.join(config.destination, "#{model_name.underscore}.rb")
    end

    def model_name
      name.singularize.camelize
    end

    def render
      ERB.new(File.read(template)).result(binding)
    end

    private

    def template
      File.expand_path('../../templates/model.erb', __FILE__)
    end
  end
end
