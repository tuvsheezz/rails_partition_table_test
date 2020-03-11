class CreateClicks < ActiveRecord::Migration[6.0]
  def change
    create_table :clicks, id: false do |t|
      t.integer :id, null: false, limit: 8
      t.integer :status
      t.string :uuid, null: false
      t.datetime :click_timestamp, null: false

      t.timestamps
    end

    add_index :clicks, :click_timestamp

    execute 'alter table clicks add primary key(id, click_timestamp);'

    execute 'alter table clicks modify id bigint(20) not null auto_increment;'

    execute ('alter table clicks partition by range columns(click_timestamp) (' +
      ('2020'..'2040').to_a.map{ |year|
        ('01'..'12').to_a.map{ |month|
          "partition p#{year}#{month} values less than ('#{year}-#{month}-01 00:00:00') comment = '#{year}#{month}' engine innodb"
        }
      }.flatten.join(",") + ');'
    )
  end
end
