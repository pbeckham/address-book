module ApplicationHelper

  def active_class path
    'active' if current_page?(path)
  end

  def bootstrap_class_for type
    case type
    when 'success' then 'alert-success'
    when 'error'   then 'alert-danger'
    when 'alert'   then 'alert-warning'
    when 'notive'  then 'alert-info'
    else type
    end
  end
end
