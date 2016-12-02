Sequel.migration do
  transaction
  change do
    create_table(:users) do
      primary_key :id
      String :username, text: true, null: false
      String :password, text: true, null: false
      String :avatar, text: true, null: false
      Bignum :role, null: false
    end

    create_table(:posts) do
      primary_key :id
      foreign_key :user_id, :users, :null=>false, :key=>[:id]
      String :title, text: true, null: false
      String :source, text: true, null: false
      String :content, text: true, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    create_table(:comments) do
      primary_key :id
      String :nickname, text: true, null: true
      String :content, text: true, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end
  end
end