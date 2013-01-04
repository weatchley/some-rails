module Some
  class Login
    
    attr_accessor :username, :password, :company_id, :leader_id, :clear_text_p
    #attr_reader :username, :account
    #attr_writer :password
    
    def initialize(company_id = nil, username = "", password = nil, leader = 0)
      @user = nil
      @company_id = company_id
      @company = Some::Company.fetch(company_id)
      self.company_id = company_id
      self.username = username.downcase
      self.password = password
      self.company_id = company_id
      self.leader_id = leader
    end
    
    def password
      ''
    end
    
    def username=(value)
      return nil unless value
      @username = value.downcase
    end
    
    def authenticated?(user=nil)
      Rails.logger.debug "**** Some Login - Got here 1 ****"
      return nil unless @user = user
      return false if @user.locked_out?
      return false if (!@user.active)
      Rails.logger.debug "**** Some Login - Got here 2 - #{@user.id} ****"
      result = Some::User.validate_password(@user, self.clear_text_p)
      Rails.logger.debug "**** Some Login - Got here 3 - #{result}, #{self.username} ****"
      result
    end
    
    def user_id
      (self.authenticated?) ? @user.id : nil
    end
    
  end
end