module Some
  class User < ActiveRecord::Base
    #set_dataset dataset.order(:id, :company_name)

	belongs_to :companies
    
	def self.fetch(lookup_id=nil)
	  result = self.where(:id => lookup_id).first
	end
        
    def full_name
      "#{self.first_name} #{self.last_name}"
    end
    
    def to_s
      #"#{self.id}, #{self.ga_id}, #{self.email}, #{self.first_name},  #{self.last_name}, #{self.is_leader}, #{self.password}, #{self.password_confirmation}, #{self.phone}, #{self.active}, #{self.failed_login_count}" 
      "#{self.id}: #{self.username} #{self.email} (#{self.first_name} #{self.last_name})"
    end
    
    def phone=(phone)
      super(phone.to_s.gsub(/\D/, ''))
    end
    
    def format_phone
      result = "(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..20]}"
    end
    
    def security_answer=(security_answer)
      super(security_answer.downcase)
    end
    
    def self.encrypt_value(user=nil, value=nil)
      cipher = Gibberish::AES.new("#{user.email}Some#{user.id}")
      enc = cipher.enc(value)
      enc
    end
    
    def self.set_password(user=nil, password=nil)
      result = false
      user.password = self.encrypt_value(user, password)
      user.save
      result = true
      
      result
    end
    
    def self.validate_password(user=nil, password=nil)
      result = false
      if password == self.get_cvalue(user)
        result = true
      end
      result
    end
    
    def self.get_cvalue(user=nil)
      result = nil
      if user.password != nil
        cipher = Gibberish::AES.new("#{user.email}Some#{user.id}")
        result = cipher.dec(user.password)
      end
      
      result
    end
    
    def self.username_in_use(comp=nil, test_username=nil)
      result = false
      u = nil
      u = self.where(:username => test_username, :test_username => comp.id).first
      result = (u != nil) ? true : false
    end
    
    def self.get_user_list(comp=nil)
      result = []
      list = nil
      list = self.where(:test_username=>comp.id).order(:last_name).all
      i = 0
      list.each do |item|
        result[i] = [item.id, item.full_name]
        i += 1
      end
      result
    end
    
    def locked_out?
      self.failed_login_count >= Some::CONFIG['failed_login_lockout']
    end
    
    def self.send_password_email(user=nil)
      subject = "App Login help"
      
      message =  %[To: #{user.email}\n]
      message += %[From: #{Comf5::CONFIG['notify_from']}\n]
      message += %[Subject: #{subject}\n\n]
      message += %[#{subject}\n]
      message += "password: #{Tracker::User.get_cvalue?(user)}\n"
      
      begin
       # Net::SMTP.start(Comf5::CONFIG['smtp_server'], Comf5::CONFIG['smtp_port'], Comf5::CONFIG['smtp_domain'], Comf5::CONFIG['smtp_user'], Comf5::CONFIG['smtp_password'], :login) do |smtp|
       #   smtp.send_message message, Comf5::CONFIG['notify_from'], user.email
       # end
      rescue => ex
        #Uam::AppLog.log(:error, "Could not send notification email for tracker app (#{user.ga_id}) user #{user.email} because \"#{ex.message}\".")
      end
      
      message
      
    end

    
  end
end