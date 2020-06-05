//
//  RegionTableViewCellModel.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import Foundation
import UIKit

class RegionTableViewCellModel {
    
    var identifier: String = ""
    
    var name: String = ""
    
    var region: RegionModel?
    
    init(with region: RegionModel) {
        self.update(with: region)
    }
    
    func update(with region: RegionModel) {
        self.region = region
        self.name = region.name
        self.identifier = region.identifier
    }
    
    
}
