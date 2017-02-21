require 'spec_helper'

RSpec.describe MagicModels::Model do
  let(:config) { MagicModels::Configuration.new }
  it 'renders properly' do
    model = described_class.new(config, 'bars')

    expect(model.render).to match(<<~EOMODEL)
    class Bar < ActiveRecord::Base
      self.table_name = "bars"
      self.primary_key = :id

      belongs_to :foo,
        class_name: "Foo",
        foreign_key: :foo_id,
        primary_key: :id

    end
    EOMODEL
  end
end
