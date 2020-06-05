//
//  RegionTableViewCell.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelId: UILabel!
    
    var disposeBagCell:DisposeBag = DisposeBag()
    
    var viewModel: RegionTableViewCellModel?

    func update(with model: RegionTableViewCellModel) {
        self.viewModel = model
        self.labelName.text = model.name
        self.labelId.text = model.identifier
    }

    override func prepareForReuse() {
        disposeBagCell = DisposeBag()
    }
}
