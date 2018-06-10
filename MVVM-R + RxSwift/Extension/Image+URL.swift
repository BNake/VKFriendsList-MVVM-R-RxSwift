//
//  Image+URL.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 01/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift


extension UIImage {
    static func getImage(link: String?) -> Observable<UIImage> {
        return Observable.create { observable in
            guard let link = link, let url = URL(string: link) else { observable.onNext(#imageLiteral(resourceName: "Guf")); return Disposables.create() }
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        let image = UIImage(data: data)
                        observable.onNext(image!)
                    } else {
                        observable.onNext(#imageLiteral(resourceName: "Guf"))
                    }
                }
                }.resume()
            
            return Disposables.create()
        }
    }
    
//    static func getImageArray(links: [String], completion: @escaping([UIImage]) -> ()){
//        var imageArray = [UIImage]()
//        
//            let _ = links.map({
//                if let imageData = try? Data(contentsOf: URL(string: $0)!) {
//                   imageArray.append(UIImage(data: imageData)!)
//                }
//            })
//        
//        completion(imageArray)
//        
//    }
}
