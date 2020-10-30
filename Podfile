source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
install! 'cocoapods',
         warn_for_multiple_pod_sources: false,
         deterministic_uuids: false,
         generate_multiple_pod_projects: true,
         integrate_targets: false

use_frameworks!(linkage: :static)

pod 'SquarePointOfSaleSDK',
  path: './',
  appspecs: %w[SampleApp],
  testspecs: %w[Tests]
  
