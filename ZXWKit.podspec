Pod::Spec.new do |spec|
  spec.name = "ZXWKit"
  spec.version = "1.0.0"
  spec.summary = "zhuangxiaowei's Kit framework"
  spec.homepage = "http://weibo.com/u/1862433935"
  spec.license = { :type => 'MIT', :file => 'LICENSE'}
  spec.authors = { "Zhuange Xiaowei" => 'zhuangxiaowei_dev@163.com'}
  spec.source = { :git => "https://github.com/Tytran2013/ZXWKit.git", :tag => "v#{spec.version}", :submodules => true}
  spec.source_files = "ZXWKit/**/*.{h,m}"
  spec.platform = :ios
  spec.ios.deployment_target = "8.0"
end
