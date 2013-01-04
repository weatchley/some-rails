module ApplicationHelper
  def title(page_title); content_for(:title) { page_title.to_s.html_safe }; end
  
  def base_errors(model)
    other_errors = false
    model.errors.each do |k, v|
      if (k != :base) and (k != :transaction) and v
        other_errors = true
        break
      end
    end
    
    render 'ajax/base_errors',
      :other_errors => other_errors,
      :base_errors => model.errors[:base],
      :transaction_errors => model.errors[:transaction]
  end
  
  def field_info(body)
    render 'ajax/field_info', :body => body
  end
  
  def field_errors(model, field_name, field_label = nil)
    errors = model.errors[field_name]
    
    field_label = field_name.to_s.humanize unless field_label
    render 'ajax/field_errors',
      :field_name => field_name,
      :field_label => field_label,
      :errors => errors if errors.size > 0
  end
  
  def field_messages(model, field_name, field_label = nil, &info_block)
    info_body = nil
    info_body = capture(&info_block) if block_given?
    
    render 'ajax/field_messages',
      :model => model,
      :field_name => field_name,
      :field_label => field_label,
      :errors => model.errors[field_name],
      :info_body => info_body
  end
  
  def form_url(form)
    
  end

  end
