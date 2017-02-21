ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'magic_models'
)

ActiveRecord::Schema.define do
  create_table :foos, force: :cascade

  create_table :bars, force: true do |t|
    t.belongs_to :foo, foreign_key: :cascade
  end
end
