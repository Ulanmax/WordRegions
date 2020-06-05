platform :ios, '11.0'

def rx_swift
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxOptional'
pod 'Alamofire'
    pod 'RxAlamofire'
end

def rx_cocoa
  pod 'RxCocoa'
  pod 'RxDataSources'
  pod 'RxNuke'
end


# CocoaLumberjack is a fast & simple, yet powerful & flexible logging framework for Mac and iOS.
def cocoaLumberjack
  pod 'CocoaLumberjack/Swift'
end

target 'Bekitzur' do
  use_frameworks!

    rx_cocoa
    rx_swift
    cocoaLumberjack
    pod 'DTTableViewManager', '~> 6.0'
    pod 'IQKeyboardManagerSwift'
    pod 'PKHUD', '~> 5.0'

  target 'BekitzurTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'BekitzurUITests' do
    # Pods for testing
  end

end
