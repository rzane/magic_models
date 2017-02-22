require 'spec_helper'

RSpec.describe MagicModels::Model do
  let(:schema) { MagicModels::Schema::Define.new }

  before do
    schema.append 'bars', 'blah'
    schema.append 'bars', 'deet'
  end

  it 'renders properly' do
    model = described_class.new(schema, 'bars')

    expect(model.render).to match(<<~EOMODEL)
    class Bar < ActiveRecord::Base
      self.table_name = "bars"
      self.primary_key = :id

      belongs_to :foo,
        class_name: "Foo",
        foreign_key: :foo_id,
        primary_key: :id

      blah
      deet
    end
    EOMODEL
  end
end
