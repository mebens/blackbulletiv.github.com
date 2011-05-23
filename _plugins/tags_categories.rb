# Thanks to http://recursive-design.com/projects/jekyll-plugins/ for much of the code
require_relative 'filters'

module Jekyll
  class CustomPage < Page
    def initialize(site, base, dir, layout)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'
      
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), layout + '.html')
    end
  end
  
  class Category < CustomPage
    def initialize(site, base, dir, category)
      super site, base, dir, 'category'
      self.data['category'] = category
      self.data['title'] = "#{site.config['category_title_prefix'] || 'Category: '}#{category}"
      self.data['description'] = "#{site.config['category_meta_description_prefix'] || 'Category: '}#{category}"
    end
  end
  
  class Categories < CustomPage
    def initialize(site, base, dir)
      super site, base, dir, 'categories'
      self.data['title'] = site.config['categories_title'] || 'Categories'
      self.data['categories'] = site.categories.keys
    end
  end
  
  class Tag < CustomPage
    def initialize(site, base, dir, tag)
      super site, base, dir, 'tag'
      self.data['tag'] = tag
      self.data['title'] = "#{site.config['tag_title_prefix'] || 'Tag: '}#{tag}"
      self.data['description'] = "#{site.config['tag_meta_description_prefix'] || 'Tag: '}#{tag}"
    end
  end
  
  class Tags < CustomPage
    def initialize(site, base, dir)
      super site, base, dir, 'tags'
      self.data['title'] = site.config['tags_title'] || 'Tags'
      self.data['tags'] = site.categories.keys
    end
  end
  
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.render
      self.generate_tags_categories # this must come after render
      self.cleanup
      self.write
    end
    
    def generate_tags_categories
      throw "No 'category' layout found." unless self.layouts.key? 'category'
      throw "No 'categories' layout found." unless self.layouts.key? 'categories'
      throw "No 'tag' layout found." unless self.layouts.key? 'tag'
      throw "No 'tags' layout found." unless self.layouts.key? 'tags'
      
      # Categories
      dir = self.config['category_dir'] || 'categories'
      write_page Categories.new(self, self.source, dir)
      
      self.categories.keys.each do |category|
        write_page Category.new(self, self.source, File.join(dir, category.slugize), category)
      end
      
      # Tags
      dir = self.config['tag_dir'] || 'tags'
      write_page Tags.new(self, self.source, dir)
      
      self.tags.keys.each do |tag|
        write_page Tag.new(self, self.source, File.join(dir, tag.slugize), tag)
      end
    end
    
    private
      
      def write_page(page)
        page.render(self.layouts, site_payload)
        page.write(self.dest)
        self.pages << page
      end
  end
end
