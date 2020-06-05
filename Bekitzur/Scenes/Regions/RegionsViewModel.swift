//
//  RegionsViewModel.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class RegionsViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
        let searchTrigger: Driver<String>
        let selection: Driver<IndexPath>
    }
    struct Output {
        let fetching: Driver<Bool>
        let regions: Driver<[RegionTableViewCellModel]>
        let selectedRegion: Driver<Void>
        let error: Driver<Error>
    }
    
    private let useCase: RegionsNetwork
    private let navigator: RegionNavigator
    
    init(useCase: RegionsNetwork, navigator: RegionNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        let regions = input.trigger.flatMapLatest { value -> SharedSequence<DriverSharingStrategy, [RegionModel]> in
                    return self.useCase.fetchRegions()
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }.map {
                    $0.map { (region) -> RegionTableViewCellModel in
                        RegionTableViewCellModel(with: region)
                    }
                }
        
        let search = Driver.combineLatest(input.searchTrigger, regions).map { (value) -> [RegionTableViewCellModel] in
            return value.1.filter { (model) -> Bool in
                model.name.contains(value.0) || value.0 == ""
            }
        }
        
        let selectedRegion = input.selection.withLatestFrom(regions) { (indexPath, regions) -> RegionTableViewCellModel in
                return regions[indexPath.row]
            }
        .do(onNext:
            { [weak self] (cellModel) in
                if let region = cellModel.region {
                    self?.navigator.toRegionDetails(region)
                }
            }
        ).mapToVoid()
        
        return Output(fetching: fetching,
                      regions: search,
                      selectedRegion: selectedRegion,
                      error: errors)
    }
}

