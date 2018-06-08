//
//  FeedTableViewCell.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 03/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift
import RxCocoa

class FeedTableViewCell: UITableViewCell {
    
    private var disposeBag = DisposeBag()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var feedImageView: UIImageView!
    
    func setup(with viewModel: FeedCellViewModel){
        photoImageView.rounding()
        viewModel.photo.drive(onNext: { (image) in
            self.photoImageView.image = image
        }).disposed(by: disposeBag)
        
        fullNameLabel.text = viewModel.fullName
        dateLabel.text = viewModel.date
        titleLabel.text = viewModel.title
        
        likeButton.setTitle(viewModel.likesCount, for: .normal)
        repostButton.setTitle(viewModel.repostCount, for: .normal)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
