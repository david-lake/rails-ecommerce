module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Company Name"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def format_price(int)
    '%.2f' % int
  end
end
