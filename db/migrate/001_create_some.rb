class CreateSome < ActiveRecord::Migration
  def up
    create_table :companies do |t|
      #primary_key :id
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
	  t.string :company_name
      t.boolean :active, null: false, default: true
      t.string :address, size: 80, null: false
      t.string :city, size: 80, null: false
      t.string :state, size: 2, null: false
      t.string :zip, size: 10, null: false
      t.string :phone, size: 20, null: true
      t.string :fax, size: 20, null: true
	  t.string :web_site, size: 120, null: true
    end
	
    create_table :locations do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
	  t.string :description, size: 80, bull: false
    end
	#add_foreign_key(:locations, :companies)
	
    create_table :users do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
	  t.string :username, size: 20, null: false
      t.boolean :active, null: false, default: true
	  t.string :email, size: 256, null: false
	  t.string :password, size: 60, null: false
	  t.string :first_name, size: 64, null: false
	  t.string :last_name, size: 64, null: false
	  t.string :phone, size: 16
      t.integer :failed_login_count, default: 0, null: false
	  t.datetime :last_attempt, null: true
	  t.string :security_question, size: 80, null: false
	  t.string :security_answer, size: 80, null: false
	  t.datetime :last_login, null: true
      t.datetime :date_created, null: true
      t.datetime :date_canceled, null: true
    end
	#add_foreign_key(:users, :companies)
	
    create_table :associates do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
	  t.integer :user_id, null: false
    end
	#add_foreign_key(:associates, :companies)
	#add_foreign_key(:associates, :users)
	
    create_table :privs do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
	  t.string :description, size: 80, bull: false
    end
	
    create_table :user_privs do |t|
      t.integer :company_id, null: false
	  t.integer :user_id, null: false
	  t.integer :priv_id, null: false
    end
	#add_foreign_key(:user_privs, :companies)
	#add_foreign_key(:user_privs, :users)
	#add_foreign_key(:user_privs, :privs)
	
    create_table :clients do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
	  t.string :last_name, size: 40, null: false
	  t.string :first_name, size: 40, null: false
	  t.string :middle_name, size: 40, null: true
      t.boolean :active, null: false, default: true
	  t.string :occupation, size: 80, null: true
	  t.string :email, size: 256, null: true
	  t.string :address, size: 80, null: true
	  t.string :city, size: 80, null: true
	  t.string :state, size: 2, null: true
	  t.string :zip, size: 10, null: true
	  t.string :phone, size: 20, null: true
	  t.string :cell, size: 20, null: true
	  t.string :fax, size: 20, null: true
      t.datetime :last_seen, null: true
      t.integer :location_id, null: true
	  t.string :notes, null: true
   end
	#add_foreign_key(:clients, :companies)
	#add_foreign_key(:clients, :locations)
   
    create_table :calendars do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
	  t.integer :client_id, null: true
      t.boolean :showed_up, null: false, default: false
	  t.date :event_date, null: false
	  t.time :begin, null: false
	  t.time :end, null: false
	  t.string :notes, null: true
    end
	#add_foreign_key(:calendar, :clients)
	
    create_table :invoice_ids do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
	  t.date :invoice_date, null: false
      t.integer :invoice_id, null: false, default: 1
    end
	#add_foreign_key(:invoice_ids, :companies)
	
    create_table :invoices do |t|
      t.integer :id, :options => 'PRIMARY KEY', :default => 1
      t.integer :company_id, null: false
      t.integer :invoice_id, null: false
	  t.integer :client_id, null: false
      t.datetime :invoice_date, null: false
	  t.string :status, size: 20, null: false
	  t.string :data, null: false
    end
	#add_foreign_key(:invoices, :clients)

  end

  def down
    drop_table :invoice_ids
    drop_table :invoices
    drop_table :calendar
    drop_table :clients
    drop_table :user_privs
    drop_table :privs
    drop_table :associates
    drop_table :users
    drop_table :locations
    drop_table :companies
  end
end