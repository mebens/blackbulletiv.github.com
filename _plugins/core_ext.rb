class String
  def slugize
    self.downcase.gsub(/[^\w\d\-]/, '-')
  end
end
