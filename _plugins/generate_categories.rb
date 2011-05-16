# Thanks to http://recursive-design.com/projects/jekyll-plugins/ for much of the code
require_relative 'filters'

module Jekyll
  class Category < Page
    def initialize(site, base, category_dir, category)
      @site = site
      @base = base
      @dir  = category_dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'category.html')
      
      self.data['category']    = category
      self.data['title']       = "#{site.config['category_title_prefix'] || 'Category: '}#{category}"
      self.data['description'] = "#{site.config['category_meta_description_prefix'] || 'Category: '}#{category}"
    end
  end
  
  class Categories < Page
    def initialize(site, base, category_dir)
      @site = site
      @base = base
      @dir = category_dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'categories.html')
      
      self.data['title'] = site.config['categories_title'] || 'Categories'
      self.data['categories'] = site.categories.keys
    end
  end
  
  class Site
    def generate_categories
      if self.layouts.key? 'category'
        dir = self.config['category_dir'] || 'categories'
        write_page Categories.new(self, self.source, dir)
        
        self.categories.keys.each do |category|
          write_page Category.new(self, self.source, File.join(dir, category.slugize), category)
        end
      else
        throw "No 'category' layout found."
      end
    end
    
    private
      
      def write_page(page)
        page.render(self.layouts, site_payload)
        page.write(self.dest)
        self.pages << page
      end
  end
  
  class GenerateCategories < Generator
    safe true
    priority :low

    def generate(site)
      site.generate_categories
    end
  end
end
