module Some
  class Calendar < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)
    
	has_many :clients
	belongs_to :companies
	
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
    
    
  end
end