class CreateDescriptions < ActiveRecord::Migration
	def change
		create_table :descriptions do |t|
			t.string :lang, limit: 2, null: false

			t.string :title
			t.string :abstract
			t.text   :body

			t.timestamps
		end

		add_index :descriptions, :lang
	end
end
