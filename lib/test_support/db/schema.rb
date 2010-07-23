require 'sniff/database'

Sniff::Database.define_schema do
  create_table "pet_records", :force => true do |t|
    t.string   "name"
    t.integer  "species_id"
    t.integer  "breed_id"
    t.integer  "gender_id"
    t.float    "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.date     "acquisition"
    t.date     "retirement"
  end
end
