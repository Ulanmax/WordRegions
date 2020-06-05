//
//  RegionsNetwork.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import RxSwift

public final class RegionsNetwork {
    private let network: Network<RegionModel>
    
    private let path = "region/list"
    
    init(network: Network<RegionModel>) {
        self.network = network
    }
    
    public func fetchRegions() -> Observable<[RegionModel]> {
        return network.getItems(path).map({ (result) -> [RegionModel] in
            return result.results ?? []
        })
    }
}
