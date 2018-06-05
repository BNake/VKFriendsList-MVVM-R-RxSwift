//
//  View+Radius.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 03/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import UIKit


extension UIView {
    func radius(radius: CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func rounding() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
}
