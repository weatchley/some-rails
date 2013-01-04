module Some
  class Company < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)
	
	#has_many :clients
	has_many :calendars
	#has_many :associates
	#has_many :locations
	has_many :users
	has_many :invoices
    
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
    
    def self.get_company_list
      result = {}
      list = Some::Company.all
      list.each do |obj|
        result[obj.id] = obj.company_name
      end
      result
    end
    
  end
end