//
//  ProfileViewController.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 03/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift
import RxCocoa
import RxGesture

class ProfileViewController: UIViewController {

    private let viewModel: ProfileViewModel
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var profileView: UIView!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var friendListButton: UIButton!
    
    
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.rounding()
        messageButton.rounding()
        friendListButton.rounding()
        
        profileView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 400)
        self.view.addSubview(profileView)
        
//        let cellNib = UINib(nibName: String(describing: FeedTableViewCell.self), bundle: nil)
//        tableView.register(cellNib, forCellReuseIdentifier: "FeedCell")
//
//        viewModel.feed.drive(tableView.rx.items(cellIdentifier: "FeedCell", cellType: FeedTableViewCell.self)) { (row, feed, cell) in
//            cell.setup(with: feed)
//            }.disposed(by: disposeBag)
        
        
        viewModel.photo.bind(to: photoImageView.rx.image).disposed(by: disposeBag)
        viewModel.fullName.bind(to: fullNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.onlineStatus.bind(to: onlineStatusLabel.rx.text).disposed(by: disposeBag)
        viewModel.city.bind(to: cityLabel.rx.text).disposed(by: disposeBag)
        
        photoImageView.rx.anyGesture(.tap()).when(.recognized).subscribe { [weak self] gesture in
            self?.viewModel.detailPhoto((self?.photoImageView.image!)!)
            }.disposed(by: disposeBag)

        friendListButton.rx.tap.subscribe { [weak self] _ in
            self?.viewModel.friendList()
        }.disposed(by: disposeBag)
    }
}
