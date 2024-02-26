source 'https://github.com/cocoapods/specs.git'

platform :ios, "13.0"
use_frameworks!

def available_pods

  # UI
  pod 'SnapKit'
  pod 'NMEasyTipView', '~> 1.2'
  pod 'lottie-ios'
  pod 'Kingfisher', '~> 7.0'
  pod 'Alamofire'
 
end

target "GeneratorPhoneWallpaper" do
  available_pods
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
          # M1 Simulator
          config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
          
          # Set deployment target to disable warnings
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end
