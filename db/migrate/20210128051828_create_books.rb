class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.bigint :user_id # MEMO: 親のid。今回はuserが親。
      t.string :title
      t.string :body
      t.timestamps
    end
  end
end
