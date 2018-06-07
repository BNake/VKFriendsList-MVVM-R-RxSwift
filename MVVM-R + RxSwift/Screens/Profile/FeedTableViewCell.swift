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
        
//        viewModel.images.subscribe { images in
//            guard let images = images.element else { return }
//            self.stackView.arrangedSubviews.filter{$0 == UIImageView() && $0 != self.feedImageView}.forEach{self.stackView.removeArrangedSubview($0)}
//            
//            var imageViewArray = [UIImageView]()
//            
//            images.forEach { image in
//                let imageView = UIImageView()
//                imageView.contentMode = .scaleAspectFit
//                imageView.frame.size = image.size
//                imageView.image = image
//                imageViewArray.append(imageView)
//                //self.stackView.insertSubview(self.titleLabel, aboveSubview: imageView)
//            }
//            
//            let stackView = UIStackView()
//            stackView.distribution = .fillProportionally
//            imageViewArray.forEach{stackView.addArrangedSubview($0)}
//            self.stackView.insertArrangedSubview(stackView, at: 2)
//            }.disposed(by: disposeBag)
    }
    
    override func prepareForReuse() {
        disposeBag = DisposeBag()
    }
}
