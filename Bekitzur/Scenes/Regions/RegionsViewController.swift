//
//  RegionsViewController.swift
//  Bekitzur
//
//  Created by Maks Niagolov on 2020/06/05.
//  Copyright © 2020 Maksim Niagolov. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: RegionsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    private func configureUI() {
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel() {
        guard let viewModel = self.viewModel else {
            return
        }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        
        let searchTrigger = searchBar.rx.text.orEmpty
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .asDriver(onErrorJustReturn: "")
        
        let input = RegionsViewModel.Input(
            trigger: viewWillAppear,
            searchTrigger: searchTrigger,
            selection: tableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input: input)
        
        [
            output.regions.drive(tableView.rx.items(cellIdentifier: "RegionTableViewCell", cellType: RegionTableViewCell.self)) { tv, viewModel, cell in
                cell.update(with: viewModel)
            },
            output.error.drive(errorBinding),
            output.selectedRegion.drive()
        ]
        .forEach({$0.disposed(by: disposeBag)})
        
    }
    
    var favContentBinding: Binder<String> {
        return Binder(self, binding: { (vc, title) in
            print(title)
        })
    }
}
