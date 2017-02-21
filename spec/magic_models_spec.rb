require "spec_helper"

RSpec.describe MagicModels do
  after do
    hide_const 'Foo'
    hide_const 'Bar'
  end

  it 'generates a model' do
    expect { Foo }.to raise_error(NameError)
    MagicModels.define
    expect(Foo.count).to eq(0)
  end

  it 'dumps a model' do
    dir = Dir.mktmpdir 'magic_models'

    MagicModels.dump do |config|
      config.destination = dir
    end

    contents = File.read(File.join(dir, 'foo.rb'))
    expect(contents).to match(/class Foo < ActiveRecord::Base/)
  end

  it 'defines associations' do
    MagicModels.define
    expect(Bar.reflect_on_association(:foo)).not_to be_nil
  end
end
