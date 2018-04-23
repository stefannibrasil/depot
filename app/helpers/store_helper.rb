module StoreHelper
  def counter
    if @counter > 5
      "You have accessed our Catalog #{pluralize(@counter, 'time')}"
    end
  end
end
