//
//  FriendListViewController.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 02/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift

class FriendListViewController: UIViewController {
    
    let viewModel: FriendListViewModel
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: FriendListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Friends"
        
        let cellNib = UINib(nibName: String(describing: FriendTableViewCell.self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "FriendCell")
        tableView.rowHeight = 80
        
        viewModel.cellViewModel?
            .drive(tableView.rx.items(cellIdentifier: "FriendCell", cellType: FriendTableViewCell.self)){ row, cellViewModel, cell in
                cell.setup(with: cellViewModel)
            }.disposed(by: disposeBag)
        
        viewModel.viewModelSelected = tableView.rx
            .modelSelected(FriendCellViewModel.self).asDriver()
    }
}
