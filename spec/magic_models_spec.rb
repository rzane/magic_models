require "spec_helper"

module MMExampleNamespace
end

RSpec.describe MagicModels do
  after do
    hide_const 'Foo'
    hide_const 'Bar'
    hide_const 'Nmsp'
  end

  describe '.define' do
    it 'generates a model' do
      expect { Foo }.to raise_error(NameError)
      MagicModels.define
      expect(Foo.count).to eq(0)
    end

    it 'returns the models that were defined' do
      models = MagicModels.define
      expect(models).to match_array([Foo, Bar])
    end

    it 'defines associations' do
      MagicModels.define
      expect(Bar.reflect_on_association(:foo)).not_to be_nil
    end

    it 'can bind to a namespace' do
      expect { MMExampleNamespace::Foo }.to raise_error(NameError)

      MagicModels.define do |config|
        config.namespace = MMExampleNamespace
      end

      expect(MMExampleNamespace::Foo.count).to eq(0)
    end
  end

  describe '.dump' do
    let(:dir) { Dir.mktmpdir 'magic_models' }

    it 'dumps a model' do
      dir = Dir.mktmpdir 'magic_models'

      MagicModels.dump do |config|
        config.destination = dir
      end

      contents = File.read(File.join(dir, 'foo.rb'))
      expect(contents).to match(/class Foo < ActiveRecord::Base/)
    end
  end
end
