class PagesSupport

  def self.get_page(page_name)
    begin
      return page_name.constantize.new
    rescue NameError
      raise PageNotFoundException, "There is no page named #{page_name}."
    end
  end

end
