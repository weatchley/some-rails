module Some
  class Client < ActiveRecord::Base
    include ActiveModel::Validations
    #set_dataset dataset.order(:last_name, :first_name)

	#belongs_to :companies
    
	attr_accessible :company_id, :last_name, :first_name, :middle_name, :active, :occupation, :email, :address, :city, :state, :zip, :phone, :cell, :fax, :last_seen, :location_id, :notes
	
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
     
    def to_s
      "#{self.id}: #{self.last_name}, #{self.first_name}"
    end
	
	def full_name
	  "#{self.first_name} #{((self.middle_name != nil and self.middle_name > " ") ? " #{self.middle_name}" : "")} #{self.last_name}"
	end
	
	def self.get_client_list(company=nil, city=nil, state=nil)
	  result = []
	  dataset = nil
	  if city == nil and state == nil
	    dataset = self.where(:company_id => company.id).order(:last_name, :first_name)
	  elsif city != nil and state == nil
	    dataset = self.where(:company_id => company.id, :city => city).order(:last_name, :first_name)
	  elsif city == nil and state != nil
	    dataset = self.where(:company_id => company.id, :state => state).order(:last_name, :first_name)
	  elsif city != nil and state != nil
	    dataset = self.where(:company_id => company.id, :city => city, :state => state).order(:last_name, :first_name)
	  end
	  i = 0
	  dataset.each do |obj|
	    result[i] = obj.city
		i += 1
	  end
	  result
	  
	end
   
    def self.city_list(company=nil)
	  result = []
	  dataset = self.where(:company_id => company.id).order(:city).select(:city).uniq
	  i = 0
	  dataset.each do |obj|
	    result[i] = obj.city
		i += 1
	  end
	  result
	end
   
    def self.state_list(company=nil)
	  result = []
	  dataset = self.where(:company_id => company.id).order(:state).select(:state).uniq
	  i = 0
	  dataset.each do |obj|
	    result[i] = obj.state
		i += 1
	  end
	  result
	end
    
  end
end