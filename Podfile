# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'Run Up' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RunUp
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'
  pod 'Firebase/Storage'
  pod 'SnapKit',    '~> 4.0.1'
  pod 'RxSwift',    '~> 4.3.1'
  pod 'RxCocoa',    '~> 4.3.1'
  pod 'Alamofire',  '~> 4.7'
  pod 'RealmSwift'
  pod 'BEMCheckBox'
  pod 'NVActivityIndicatorView',  '~> 4.4.0'
  pod 'IQKeyboardManagerSwift'
  pod 'FBSDKCoreKit', '4.35'
  pod 'FBSDKLoginKit', '4.35'
  pod 'SelectionDialog'
  
end

target 'Run UpTests' do
    inherit! :search_paths
    # Pods for testing
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    installer.pods_project.targets.each do |target|
        if ['SelectionDialog'].include? target.name
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
end
