
Pod::Spec.new do |s|
    s.name         = 'WLDevelopmentTools'
    s.version      = '1.0.0'
    s.summary      = 'An easy way to use WLDevelopmentTools'
    s.homepage     = 'https://github.com/DaLiangWang/WLMqtt'
    s.license      = 'MIT'
    s.authors      = {'wangliang' => 'wlhjx1993@gmail.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/DaLiangWang/WLSandBox.git', :tag => s.version}
    s.source_files = "WLDevelopmentToolsDeom/WLDevelopmentTools/*.{h,m}"
    s.requires_arc = true

end