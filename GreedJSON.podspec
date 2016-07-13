Pod::Spec.new do |s|

  s.name         = "GreedJSON"
  s.version      = "0.1.6"
  s.summary      = "parse and format JSON for ios "
  s.description  = %{Format NSDictionary,NSArray and NSData to JSONString,or reverse }
  s.homepage     = "https://github.com/greedlab/GreedJSON"
  s.license      = "MIT"
  s.author       = { "Bell" => "bell@greedlab.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/greedlab/GreedJSON.git", :tag => s.version }
  s.source_files  = "GreedJSON", "GreedJSON/*.{h,m}"
  s.framework  = "Foundation"
  s.requires_arc = true

end
