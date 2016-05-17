class CreateTables < ActiveRecord::Migration
  def change
    create_table :organisations do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :people do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end

    create_table :memberships do |t|
      t.references :organisation, index: true
      t.references :people, index: true

      t.timestamps null: false
    end

    create_table :contact_details do |t|
      t.references :contactable, polymorphic: true, index: true
      t.string :email
      t.string :telephone
      t.string :address_line_1
      t.string :address_line_2
      t.string :address_line_3
      t.string :city
      t.string :postal_code
      t.string :country_code


      t.timestamps null: false
    end
  end
end
