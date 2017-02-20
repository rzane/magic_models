require "spec_helper"

RSpec.describe MagicModels do
  around do |example|
    conn = ActiveRecord::Base.connection
    conn.execute 'create table foos (id integer);'
    example.run
    conn.execute 'drop table foos;'
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
end
