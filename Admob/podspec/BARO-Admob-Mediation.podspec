Pod::Spec.new do |s|
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.swift_version = "4.1.2"
  s.requires_arc = true

  s.name = "BARO-Admob-Mediation"
  s.summary = "Admob Mediation Adapter for BuzzAd Revenue Optimizer, aka BARO"
  s.version = "2.1.1"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = "Buzzvil"
  s.homepage = "https://github.com/buzzvil/baro-ios-sdk"

  s.static_framework = true
  s.source = { :git => "https://github.com/Buzzvil/BARO-iOS-Mediation-Adapters.git" }
  s.source_files = 'Admob/*.swift'

  s.dependency 'BARO', '~> 2.0'
  s.dependency 'Google-Mobile-Ads-SDK'
end
