//
//  FriendTableViewCell.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 02/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift

class FriendTableViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet{
            photoImageView.layer.cornerRadius = photoImageView.frame.width / 2
            photoImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var onlineIndicatorView: UIView! {
        didSet{
            onlineIndicatorView.layer.cornerRadius = onlineIndicatorView.frame.width / 2
            onlineIndicatorView.clipsToBounds = true
        }
    }
    
    func setup(with viewModel: FriendCellViewModel) {
        viewModel.photo.drive(onNext: { (image) in
            self.photoImageView.image = image
        }).disposed(by: disposeBag)
        
        nameLabel.text = viewModel.name
        lastName.text = viewModel.lastName
        onlineIndicatorView.isHidden = !viewModel.isOnline
    }
}
