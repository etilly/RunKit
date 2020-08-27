Pod::Spec.new do |s|
    s.name = 'RunKit'
    s.version = '0.0.1'
    s.summary = 'A collection from Run Mobile'

    s.homepage = 'https://github.com/etilly/RunKit'
    s.license = { type: 'MIT', file: 'LICENSE' }

    s.authors = { 'Erwan Tilly' => 'erwan.tilly@gmail.com' }
    s.social_media_url = 'https://www.linkedin.com/in/erwan-tilly-19246a166'
  
    s.ios.deployment_target = '10.0'
    s.osx.deployment_target = '10.10'
    s.tvos.deployment_target = '9.0'
    s.watchos.deployment_target = '2.0'
  
    s.swift_version = '5.1'
    s.source = { git: 'https://github.com/etilly/RunKit', tag: s.version.to_s }
    s.source_files = 'Sources/**/*.swift'
  end