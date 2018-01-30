class CreateFlashcards < ActiveRecord::Migration[5.1]
  def change
    create_table :flashcards do |t|
      t.references :user, foreign_key: true
      t.string :korean_word

      t.timestamps
    end
  end
end
