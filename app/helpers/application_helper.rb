module ApplicationHelper
  def render_if(condition, record)
    if condition
      render record
    end
  end

  def render_counter(counter)
    if counter > 5
      "You have accessed our Catalog #{pluralize(counter, 'time')}"
    end
  end
end
