platform :ios, '9.0'
use_frameworks!

target 'KitStop' do
  pod 'Alamofire'
  pod 'KeychainSwift'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end