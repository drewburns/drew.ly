class CreateClicks < ActiveRecord::Migration
  def change
  	create_table :clicks do |t|
    	t.string :referer
    	t.integer :url_id

    	t.timestamps
    end
  end
end
