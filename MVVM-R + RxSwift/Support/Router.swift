//
//  Router.swift
//  PostsApp
//
//  Created by Enrico Querci on 19/11/2017.
//  Copyright © 2017 Enrico Querci. All rights reserved.
//

import Foundation

protocol Routable {
    associatedtype Routes
}

protocol Router {
    associatedtype RoutableType: Routable
    associatedtype Context: AnyObject
    weak var context: Context? { get set }
    func route(to route: RoutableType.Routes)
}

