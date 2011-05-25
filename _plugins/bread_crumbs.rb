module Jekyll
  class BreadCrumbs < Liquid::Tag
    def render(context)
      pieces = context.registers[:site].page.url.split(/\//)
      site_url = context.registers[:site].url
      code = %(<a href="#{site_url}">Home</a>)
      
      pieces.each_with_index do |i, s|
        link = site_url
        i.downto(0) { |n| link << "/#{pieces[n]}" }
        code << %(&raquo; <a href="#{link}">#{s.capitalize}</a>) # I hope we can do better than capitalize...
      end
      
      code
    end
  end  
end
