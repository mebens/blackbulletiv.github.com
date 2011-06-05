module Jekyll
  class Archive < CustomPage
    def self.years
      collect_archives unless @@years
      @@years
    end
    
    def self.months
      collect_archives unless @@months
      @@months
    end
    
    def self.days
      collect_archives unless @@days
      @@days
    end
    
    def self.[](year, month = nil, day = nil)
      if day
        self.days[year][month][day]
      elsif month
        self.months[year][month]
      else
        self.years[year]
      end
    end
    
    def initialize(site, base, year, month = nil, day = nil)
      dir = year.to_s
      dir += "/#{month}" unless month.nil?
      dir += "/#{day}" unless day.nil?
      super site, base, dir, 'archive'
      
      title = "Archives for "
      time = Time.new(year, month, day)
      
      if day
        title += "#{time.strftime('%B %d, %Y')}"
      elsif month
        title += "#{time.strftime('%B %Y')}"
      else
        title += year.to_s
      end
      
      self.data["title"] = title
      self.data["posts"] = Archive[year, month, day]
    end
        
    private
      
      def self.collect_archives
        @@years  = Hash.new { Array.new }
        @@months = Hash.new { Hash.new { Array.new } }
        @@days   = Hash.new { Hash.new { Hash.new { Array.new } } }
        
        @site.posts.each do |post|
          d = post.date
          @@years[d.year] << post
          @@months[d.year][d.month] << post 
          @@days[d.year][d.month][d.day] << post
        end
      end
  end
end
