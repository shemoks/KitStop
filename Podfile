platform :ios, '9.0'
use_frameworks!

target 'KitStop' do
  pod 'Alamofire'
  pod 'KeychainAccess'
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'
  pod 'IQKeyboardManagerSwift', '~> 4.0'
  pod 'SwiftyJSON', '~> 3.1'
  pod 'SDWebImage'
  pod 'RealmSwift'
  pod 'AWSS3'
  pod 'Cosmos'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['SWIFT_VERSION'] = '3.0'
    config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
