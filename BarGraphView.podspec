Pod::Spec.new do |s|
  s.name         = "BarGraphView"
  s.version      = "0.0.1"
  s.summary      = "生成年月周日等折线图和柱状图"
  s.description  = <<-DESC
                      生成年月周日等折线图和柱状图
                   DESC
  s.homepage     = "https://github.com/qscxwei/BarGraphView"
  s.license      = "MIT"
  s.author    = "qscxwei"
  s.platform     = :ios
  s.source       = { :git => "https://github.com/qscxwei/BarGraphView.git", :tag => "#{s.version}" }
  s.source_files  = "BarGraphView", "BarGraphView/BarGraphView/**/*.{h,m}"
  s.exclude_files = "BarGraphView/Exclude"
  s.public_header_files = "BarGraphView/BarGraphView/**/GraphCommonView.h"
  s.requires_arc = true

end
