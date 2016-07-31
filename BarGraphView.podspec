Pod::Spec.new do |s|
  s.name         = "BarGraphView"
  s.version      = "0.0.1"
  s.summary      = "生成年月周日等折线图和柱状图"
  s.homepage     = "https://github.com/qscxwei/BarGraphView"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author    = "qscxwei"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/qscxwei/BarGraphView.git", :tag => "0.0.1" }
  s.source_files  = "BarGraphView", "BarGraphView/BarGraphView/**/*.{h,m}"
  s.exclude_files = "BarGraphView/Exclude"
  s.public_header_files = "BarGraphView/BarGraphView/GraphCommonView.h","BarGraphView/BarGraphView/*.h"
  s.requires_arc = true

end
