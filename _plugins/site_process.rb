require 'growl'

module Jekyll
  class Site
    def process
      self.reset
      self.read
      self.generate
      self.render
      self.generate_tags_categories # this must come after render
      self.cleanup
      self.write
      
      # Growl
      Growl.notify "Build complete.", :title => "Jekyll"
    end
  end
end
