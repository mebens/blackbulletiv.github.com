module Jekyll
  module Filters
    def bread_crumbs(url)
      site_url = "/"
      code = %(<a href="#{site_url}">Home</a> &raquo;)
      pieces = url.split(/\//).reject! { |s| s.empty? || s == "index.html" }
      pieces.pop
      
      pieces.each_with_index do |s, i|
        link = site_url
        (i - 1).downto(0) { |n| link << "/#{pieces[n]}" }
        code << %( <a href="#{link}">#{s.capitalize}</a> &raquo;) # I hope we can do better than capitalize...
      end
      
      code
    end
  end  
end
