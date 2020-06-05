//
//  RegionDetailsViewController.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegionDetailsViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: RegionDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let input = RegionDetailsViewModel.Input(
            trigger: viewWillAppear
        )
        let output = viewModel.transform(input: input)
        
        [
            output.title.drive(onNext: { [weak self] (value) in
                self?.labelTitle.text = value
            }),
            output.error.drive(errorBinding)
        ]
        .forEach({$0.disposed(by: disposeBag)})
        
    }
    
    var favContentBinding: Binder<String> {
        return Binder(self, binding: { (vc, title) in
            print(title)
        })
    }
}

