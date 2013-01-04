class Main::ClientsController < MainController
  before_filter :check_is_authenticated
  
  def index
    @page_id = "index"
	@client_list = Some::Client.where(:company_id => @company.id).order("last_name, first_name")
  end
  
  def view
    @page_id = "view"
	@client = Some::Client.fetch(params[:id])
  end
   
  def search; end
  
  def list; end
  
  def new
    @client = Some::Client.new
    @client.company_id = @company.id
    @client.active = true
  end
  
  def edit
    @client = Some::Client.where(:id => params[:id]).first
    if @company.id != @client.company_id
      redirect_to(main_clients_index_path, :notice => 'Not authorized to edit client.')
    end
  end
  
  def create
    @client = Some::Client.new
    
    if @client.update_attributes(params[:some_client])
      @client.save
      redirect_to(main_clients_index_path, :notice => 'Client was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def update
    @client = Some::Client.where(:id => params[:id]).first
    if @client.update_attributes(params[:some_client])
      @client.save
      redirect_to(main_clients_index_path, :notice => 'Client was successfully updated.')
    else
      render :action => "edit"
    end
  end
  
  def delete
    @client = Some::Client.where(:id => params[:id]).first
    notice = ""
    #Rails.logger.error "********* Got Here 1 #{ @company.id }, #{ @client.company_id } *******************************" 
    if @company.id == @client.company_id
      @client.delete
      notice = 'client was deleted.'
    else
      notice = 'Not authorized to delete client.'
    end
    redirect_to(main_clients_index_path, :notice => notice)
  end
  
  
end
