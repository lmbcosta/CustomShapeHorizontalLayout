Pod::Spec.new do |s|

# 1
s.ios.deployment_target = '8.0'
s.name = "CustomShapeHorizontalLayout"
s.summary = "CollectionViewLayout that provides horizontal scroll for cells with different content modes"
s.requires_arc = true

# 2
s.version = "1.0.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4
s.author = { "Luis Costa" => "lmbcosta@hotmail.com" }

# 5
s.homepage = "https://github.com/lmbcosta"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/lmbcosta/CustomShapeHorizontalLayout.git", :tag => "#{s.version}"}

# 7
s.framework = "UIKit"

# 8
s.source_files = "CustomShapeHorizontalLayout/**/*.{swift}"

# 9
s.swift_version = "4.2"

end
