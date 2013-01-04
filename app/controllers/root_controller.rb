class RootController < ApplicationController
  before_filter :check_is_authenticated
  
  def index
    @page_id = "index"
    #@welcome_message = @app.welcome_message
    #@welcome_message = (@welcome_message != nil and @welcome_message > "            ") ? @welcome_message : @app.contact_info
    #@welcome_message = (@welcome_message != nil and @welcome_message > "            ") ? @welcome_message : "#{Some::CONFIG['welcome_message_default'].gsub("-:#username#:-",@account.username)}"
    #@msg_list = Some::Message.get_my_messages(@app, "welcome")
    #@has_messages = (@msg_list != nil and @msg_list.first != nil) ? true : false
    #if  @app.info_as_home and @user != nil
    #  redirect_to '/tracker_app/info'
    #end
  end
  
  def login
    @page_id = "login"
    @login = Some::Login.new
    @login.company_id = @company_id
    @login.username = params[:u] if params[:u]
    if @login.username == nil and session[:login_user_id]
      @login.username = Some::User[session[:login_user_id].to_i].username
    end
    @failed = false
    
    if params[:login]
      @login.username = params[:login][:username]
      @login.password = params[:login][:password]
      @login.clear_text_p = params[:login][:password]
      @login.company_id = params[:login][:company_id]
      @user = Some::User.where(:username=>@login.username, :company_id=>@login.company_id).first
      logger.debug "**** Some controller Login - Got here 1 - #{@user.id} ****"
      
      if @login.authenticated?(@user)
        logger.debug "**** Some controller Login - Got here 2 ****"
        session[:login_user_id] = @user.id
        #session[:admin_account_id] = account.id if account.is_admin?
        #check_is_valid_app
        if @user.failed_login_count > 0
          @user.failed_login_count = 0
          @user.last_attempt = nil
        end
        @user.last_login = Time.now
        @user.save
        logger.debug "**** Some controller Login - Got here 3 - company #{@comapny}, #{session[:company_id]} ****"
        redirect_to '/main/index'
      else
        if user = @user
          #user.refresh
          user.failed_login_count += 1
          @user.last_attempt = Time.now
          user.save
          @user = nil
          logger.debug "**** Some controller Login - Got here 4 - company #{@comapny}, #{session[:company_id]} ****"
          session[:login_user_id] = nil
          
          
          #Some::AppLog.log(
          #  :info,
          #  "Some User ID: #{user.id} (#{user.username}) failed to login from #{request.remote_ip}"
          #)
        else
          #Some::AppLog.log(
          #  :info,
          #  "Unknown user \"#{@login.username}\" failed to login from #{request.remote_ip}"
          #)
        end
        @failed = true
      end
    end
    
  end
  
  private
  def check_is_authenticated
    @company = nil
    @user = nil
    @associate = nil
    @is_authenticated = false
    logger.debug "**** Root controller check_is_authenticated - Got here 1 - company_id #{params[:company_id]} ****"
    if (params[:company_id] != nil)
      if (/^[\d]+$/ === params[:company_id])
        @company = Some::Company.fetch(params[:company_id].to_i)
      else
      end
      if @company != nil
        session[:company_id] = @company.id
        @company_id = @company.id
      end
    else
      if session[:company_id] != nil
        @company = Some::Company.fetch(session[:company_id].to_i)
        @company_id = @company.id
      end
    end
    if session[:login_user_id] != nil
      @user = Some::User.fetch(session[:login_user_id].to_i)
      @is_authenticated = true
    end
    logger.debug "**** Root controller check_is_authenticated - Got here 2 - company_id #{session[:company_id]} ****"
    #redirect_to 'login' unless @is_authenticated
  end
  
  def get_security_questions
	@security_questions = []
	@sq = Some::CONFIG['security_questions']
	i = 0
	@sq.each do |q|
	  @security_questions[i] = [q, q]
	  i += 1
	end
	@security_questions
  end
  
  
end
