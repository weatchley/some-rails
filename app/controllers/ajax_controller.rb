class AjaxController < ApplicationController
  layout nil
  
  def validate
    begin
      @model = params[:__model].gsub(/__/, '::_').camelize.constantize.new
      @field_name = params[:__field].to_sym
      
      # puts @field_name
      # puts param_container
      # puts "Container: #{params[param_container]}"
      
      if @model.is_a? Some::Model
        param_container = @model.linked_model.class.to_s.underscore.gsub('/', '_')
        puts param_container
        @model.set(params[param_container])
      else
        param_container = params[:__model].gsub(/^.*__/, '').to_sym
        @model.update(params[param_container])
      end
      
      @model.validate_field @field_name
    rescue
      # 404
    end
  end
  
end
