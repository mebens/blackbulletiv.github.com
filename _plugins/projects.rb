require 'octopi'
include Octopi

module Jekyll
  class Project < CustomPage
    def initialize(site, base, dir, project)
      super site, base, dir, 'project'
      self.data["title"] = project[:name]
      self.data["readme"] = project[:readme]
      self.data["download"] = project[:download]
    end
  end
  
  class Projects < CustomPage
    
  end
  
  class Site
    def generate_projects
      throw "No user specified" unless config['github_user']
      user = User.find(config['github_user'])
      user.repositories.each do |repo|
        next if config['not_projects'] and config['not_projects'][repo.name]
        project = {
          name: repo.name,
          readme: 
        }
      end
    end
  end
end
