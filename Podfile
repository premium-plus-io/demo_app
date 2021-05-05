source 'https://bitbucket.org/next-apps/private-pod-specs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '14.0'
use_frameworks!
inhibit_all_warnings!

def sharedPods
  pod 'Alamofire'
  pod 'Auth0', '~> 1.0'
  pod 'KeychainSwift'
  pod 'NextAppsKit'
end

target 'Zendesk Demo App' do
    sharedPods
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
      end
    end
    installer.pods_project.build_configurations.each do |config|
      if config.name.include?("Debug")
        config.build_settings['GCC_OPTIMIZATION_LEVEL'] = '0'
        config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
      end
    end
  end
