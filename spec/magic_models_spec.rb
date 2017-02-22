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

    it 'can bind to a namespace' do
      expect { MMExampleNamespace::Foo }.to raise_error(NameError)

      MagicModels.define do |config|
        config.namespace = MMExampleNamespace
      end

      expect(MMExampleNamespace::Foo.count).to eq(0)
    end

    it 'returns the models that were defined' do
      models = MagicModels.define
      expect(models).to match_array([Foo, Bar])
    end
  end

  describe '.dump' do
    let(:dir) { Dir.mktmpdir 'magic_models' }

    it 'dumps a model' do
      MagicModels.dump { |c| c.destination = dir }
      contents = File.read(File.join(dir, 'foo.rb'))
      expect(contents).to match(/class Foo < ActiveRecord::Base/)
    end

    it 'returns the filenames that were created' do
      result = MagicModels.dump { |c| c.destination = dir }
      expect(result.grep(/foo|bar\.rb$/).length).to eq(2)
    end
  end
end
