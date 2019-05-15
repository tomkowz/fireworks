Pod::Spec.new do |s|
  s.name                    = 'Fireworks'
  s.version                 = '1.0.0'
  s.summary                 = 'A framework for generating firework-like particle effects.'
  s.author                  = { 'Tomasz Szulc' => 'mail@szulctomasz.com' }
  s.homepage                = 'http://szulctomasz.com'
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.swift_version           = '4.0'
  s.source                  = { :git => 'https://github.com/tomkowz/fireworks.git', :tag => '1.0.0' }
  s.source_files            = 'fireworks/Fireworks/**/*.swift'
  s.ios.deployment_target   = '11.0'
end
