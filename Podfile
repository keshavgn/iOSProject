# Uncomment the next line to define a global platform for your project
source "https://github.com/CocoaPods/Specs.git"
source "https://github.com/keshavgn/iOSFramework.git"

use_frameworks!
platform :ios, '12.0'

target 'iOSProject' do
    pod 'Firebase/Core'
    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'FirebaseUI'
    pod 'FirebaseUI/Google'
    pod 'FirebaseUI/Phone'
    pod 'SwiftGen'
    pod 'HDAugmentedReality', '~> 2.3'
    pod 'iOSFramework'
    pod 'ApiAI'
    pod 'Google-Mobile-Ads-SDK'
    pod 'GoogleMaps'

plugin 'cocoapods-keys', {
    :project => "iOSProject",
    :keys => [
    "ArtsyAPIClientSecret",
    "ArtsyAPIClientKey",
    "MapsAPIKey",
    "ChatBotId",
    "AdUnitId",
    "AdApplicationId",
    ]}

  target 'iOSProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'iOSProjectUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end


post_install do |installer|
    all_targets = installer.pods_project.targets
    # Custom modification
    all_targets.each do |target|
        target.build_configurations.each do |config|
            if target.name == 'Bolts' or target.name == 'BoringSSL' or target.name == 'FBSDKCoreKit' or target.name == 'FBSDKLoginKit' or target.name == 'GoogleToolboxForMac' or target.name == 'gRPC' or target.name == 'gRPC-Core' or target.name == 'gRPC-ProtoRPC' or target.name == 'gRPC-RxLibrary' or target.name == 'GTMOAuth2' or target.name == 'GTMSessionFetcher' or target.name == 'HDAugmentedReality' or target.name == 'leveldb-library' or target.name == 'nanopb' or target.name == 'Protobuf' or target.name == 'SDWebImage'
                config.build_settings['SWIFT_VERSION'] = "4.0"
            end
        end
    end
    
    UI.title 'Thank you!' do
        UI.puts <<-EOS
        Pods install is done
        EOS
    end
   
end
