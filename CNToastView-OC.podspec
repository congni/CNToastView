Pod::Spec.new do |s|
  s.name         = 'CNToastView-OC'
  s.version      = '1.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/congni/CNToastView.git'
  s.authors      = { "葱泥" => "983818495@qq.com" }
  s.summary      = 'toast提示'
  s.description      = <<-DESC
                      A longer description of U in Markdown format.

                      * toast提示，支持富文本
                      * pod使用方法: pod "CNToastView-OC"
                      * Try to keep it short, snappy and to the point.
                      * Finally, don't worry about the indent, CocoaPods strips it!
                      DESC

  s.ios.deployment_target = '7.0'
  s.source       =  { :git => "https://github.com/congni/CNToastView.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'CNToast-OC/*.{h,m}'
  s.public_header_files = 'CNToast-OC/*.{h}'

  s.dependency 'YYText'
end