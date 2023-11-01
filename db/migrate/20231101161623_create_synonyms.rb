class CreateSynonyms < ActiveRecord::Migration[6.0]
  def change
    create_table :synonyms do |t|
      t.string :word
      t.string :synonym
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
