require 'erb'
require 'magic_models/associations'

module MagicModels
  class Model
    attr_reader :schema, :name

    delegate :base_class, to: :schema
    delegate :constantize, to: :model_name

    def initialize(schema, name)
      @schema = schema
      @name   = name
    end

    def filename
      File.join(schema.destination, "#{model_name.underscore}.rb")
    end

    def render
      erb = ERB.new(template, nil, '<>')
      erb.result(binding)
    end

    def write
      File.open(filename, 'w') { |f| f.write render }
      filename
    end

    def define
      schema.evaluate(render)
      constantize
    end

    def appends
      schema.appends[name]
    end

    def primary_key
      @primary_key ||= schema.primary_key(name)
    end

    def belongs_to
      schema.foreign_keys(name).map do |fk|
        Associations::BelongsTo.new(fk)
      end
    end

    # Currently, we only support belongs_to associations. I don't think
    # there is a way to differentiate a has_one from a has_many.
    alias associations belongs_to

    def model_name
      name.singularize.camelize
    end

    private

    def template
      @template ||= File.read(template_filename)
    end

    def template_filename
      File.expand_path('../../templates/model.erb', __FILE__)
    end
  end
end
