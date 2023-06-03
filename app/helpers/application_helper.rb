module ApplicationHelper
  
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = params[:direction] == 'asc' ? 'desc' : 'asc'
    link_to title, request.query_parameters.merge({ sort: column, direction: })
  end

end
