//
//  Application.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import Foundation

final class Application {
    static let shared = Application()

    private let networkUseCaseProvider: NetworkProvider
    
    var window: UIWindow?
    
    private init() {
        self.networkUseCaseProvider = NetworkProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        
        self.updateApperance()
        
        self.window = window
        
        openMainInterface()
    }
    
    func openMainInterface() {
        let storyboard = UIStoryboard(name: "Regions", bundle: nil)
        
        let navigationController = UINavigationController()

        let regionNavigator = RegionNavigator(services: networkUseCaseProvider,
                                                         navigationController: navigationController,
                                                         storyBoard: storyboard)
        let vc = UIViewController()
        
        vc.view.backgroundColor = .blue
        
        regionNavigator.toList()

        window?.rootViewController = navigationController
    }
    
    func updateApperance() {
        
    }
}
