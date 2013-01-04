module Some
  class Associate < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)

	#belongs_to :companies
	belongs_to :users
    
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
    
    
  end
end