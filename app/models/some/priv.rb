module Some
  class Priv < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)
    
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
    
    
  end
end