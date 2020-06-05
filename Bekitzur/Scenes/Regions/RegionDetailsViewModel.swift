//
//  RegionDetailsViewModel.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RegionDetailsViewModel: ViewModelType {
    
    private let region: RegionModel
    
    struct Input {
        let trigger: Driver<Void>
    }
    struct Output {
        let fetching: Driver<Bool>
        let title: Driver<String>
        let error: Driver<Error>
    }
    
    private let useCase: RegionsNetwork
    private let navigator: RegionNavigator
    
    init(useCase: RegionsNetwork, navigator: RegionNavigator, region: RegionModel) {
        self.useCase = useCase
        self.navigator = navigator
        self.region = region
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let title = Driver.just(self.region).startWith(self.region).map { (region) -> String in
            region.name
        }
        
        return Output(fetching: fetching,
                      title: title,
                      error: errors)
    }
}
