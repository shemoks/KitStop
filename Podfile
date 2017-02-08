platform :ios, '9.0'
use_frameworks!

target 'KitStop' do
  pod 'Alamofire'
  pod 'KeychainAccess'
  pod 'FacebookCore’, '~> 0.2.0’
  pod 'FacebookLogin', '~> 0.2.0’
  pod 'FacebookShare’, '~> 0.2.0’
  pod 'IQKeyboardManagerSwift', '~> 4.0'
  pod 'SwiftyJSON'
  pod 'SDWebImage'
  pod 'RealmSwift'
  pod 'AWSS3', '~> 2.4.16’
  pod 'Cosmos'
  pod 'Fabric'
  pod 'Crashlytics'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['SWIFT_VERSION'] = '3.0'
    config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
