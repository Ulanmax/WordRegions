//
//  RegionNavigator.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift

class RegionNavigator {
    
    let storyBoard: UIStoryboard
    let navigationController: UINavigationController
    let services: NetworkProvider
    
    init(services: NetworkProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    
    func toList() {
        let vc = storyBoard.instantiateViewController(ofType: RegionsViewController.self)
        vc.viewModel = RegionsViewModel(useCase: services.makeRegionsNetwork(),
                                        navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toRegionDetails(_ region: RegionModel) {
//        let viewModel = RegionDetailsViewModel(useCase: services.makeRegionsNetwork(), navigator: self)
//        let vc = storyBoard.instantiateViewController(ofType: RegionDetailsViewController.self)
//        vc.viewModel = viewModel
//        navigationController.pushViewController(vc, animated: true)
    }
    
}

