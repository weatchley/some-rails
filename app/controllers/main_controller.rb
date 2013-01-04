class MainController < RootController
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
  
  def logout
    @user = nil
	@company = nil
	@associate = nil
	@is_authenticated = false
	session[:company_id] = nil
	session[:login_user_id] = nil
	redirect_to '/index'
  end
   
  private
  def check_is_authenticated
    @company = nil
    @user = nil
    @associate = nil
    @is_authenticated = false
    logger.debug "**** Main controller check_is_authenticated - Got here 1 - company_id #{params[:company_id]} ****"
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
	if @user != nil and session[:company_id] == nil or @company == nil
      session[:company_id] = @user.company_id
      @company = Some::Company.fetch(session[:company_id].to_i)
	end
    logger.debug "**** Main controller check_is_authenticated - Got here 2 - company_id #{session[:company_id]}, User: #{@user} ****"
    redirect_to 'login' unless @is_authenticated
  end
 
  
end
