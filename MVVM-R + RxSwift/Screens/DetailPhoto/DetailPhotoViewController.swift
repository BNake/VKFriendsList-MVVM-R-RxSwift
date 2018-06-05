//
//  DetailPhotoViewController.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 05/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    
    private var photo: [UIImage]
    
    private var scrollView = UIScrollView()
    private var scrollViewRect: CGRect!
    private var imageViewRect: CGRect!
    
    
    @IBOutlet weak var pageController: UIPageControl!
    
    init(photo: [UIImage]) {
        self.photo = photo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollViewRect = self.view.bounds
        
        //createScrollView
        scrollView = UIScrollView(frame: scrollViewRect)
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(width: scrollViewRect.size.width * CGFloat(photo.count), height: scrollViewRect.size.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        //createImageViewInScrollView
        imageViewRect = self.view.bounds
        
        for image in photo {
            let imageView = newImageView(paramImage: image, paramFrame: imageViewRect)
            self.scrollView.addSubview(imageView)
            
            imageViewRect.origin.x += imageViewRect.size.width
        }
    }
    
    func newImageView(paramImage: UIImage, paramFrame: CGRect) -> UIImageView {
        let result = UIImageView(frame: paramFrame)
        
        result.contentMode = .scaleAspectFit
        result.image = paramImage
        
        return result
    }
}


extension DetailPhotoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //pageController.currentPage = Int(scrollView.contentOffset.x / self.view.bounds.width)
    }
}
