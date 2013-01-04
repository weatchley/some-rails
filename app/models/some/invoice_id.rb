module Some
  class InvoiceId < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)
    
	belongs_to :companies

	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end

    def self.get_next_invoice_id(company)
      today = "#{Date.today.year.to_s}-#{Date.today.month.to_s.rjust(2,'0')}-#{Date.today.day.to_s.rjust(2,'0')}"
      current = self.where(:company_id => company.id, :invoice_date => today).first
      if current == nil
        current = self.new
        current.company_id = company.id
        current.invoice_date = today.to_date
        current.invoice_id = 0
      end
      current.invoice_id += 1
      id = "#{Date.today.year.to_s}#{Date.today.month.to_s.rjust(2,'0')}#{Date.today.day.to_s.rjust(2,'0')}#{current.invoice_id.to_s.rjust(4,'0')}"
      current.save
      id
    end
    
    
  end
end