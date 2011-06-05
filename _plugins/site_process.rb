require 'growl'

module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.render
      
      # these must come after render
      self.generate_tags_categories
      self.generate_archives
      self.generate_projects
      
      self.cleanup
      self.write
      
      # Growl
      Growl.notify "Build complete.", :title => "Jekyll"
    end
  end
end
