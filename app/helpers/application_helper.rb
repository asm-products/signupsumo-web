module ApplicationHelper
  def active(route)
    'active' if current_page?(route)
  end
end
