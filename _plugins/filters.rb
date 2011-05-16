module Jekyll
  module Filters
    def slugize(text)
      text.slugize
    end
    
    def format_date(date)
      "#{date.strftime('%B')} #{date.strftime('%d')}, #{date.strftime('%Y')}"
    end
  end
end
