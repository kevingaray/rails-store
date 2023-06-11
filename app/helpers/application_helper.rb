module ApplicationHelper
  include Pagy::Frontend
  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to title, request.query_parameters.merge({ sort: column, direction: })
  end

  def decorate(object, klass = nil)
    klass ||= "#{object.class}Decorator".constantize
    decorator = klass.new(object, self)
    yield decorator if block_given?
    decorator
  end
  
end
