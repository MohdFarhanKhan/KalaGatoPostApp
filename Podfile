# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'KalaGatoPostApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for KalaGatoPostApp
 pod 'Firebase/Core'
  
  pod 'Firebase/RemoteConfig'



  target 'KalaGatoPostAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'KalaGatoPostAppUITests' do
    # Pods for testing
  end
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
         end
    end
  end
end
end






