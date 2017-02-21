require 'erb'
require 'magic_models/associations'

module MagicModels
  class Model
    attr_reader :config, :name

    delegate :base_class, to: :config
    delegate :constantize, to: :model_name

    def initialize(config, name)
      @config = config
      @name   = name
    end

    def primary_key
      @primary_key ||= config.primary_key(name)
    end

    def filename
      File.join(config.destination, "#{model_name.underscore}.rb")
    end

    def belongs_to
      config.foreign_keys(name).map do |fk|
        Associations::BelongsTo.new(fk)
      end
    end
    alias associations belongs_to

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
