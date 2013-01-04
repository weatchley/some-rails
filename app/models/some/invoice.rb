module Some
  class Invoice < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)

	belongs_to :companies
	belongs_to :clients
    
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
    
    
  end
end