//
//  AuthorizationViewController.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 05/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import SafariServices
import RxSwift

class AuthorizationViewController: UIViewController, Routable {
    
    typealias RouterType = AuthorizationRouter
    var router: AuthorizationRouter?
    
    enum Routes {
        case friendList(id: Int)
    }
    
    private var safariController: SFSafariViewController?
    private let keychain: Keychain
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var loginButton: UIButton!
    
    init(keychain: Keychain) {
        self.keychain = keychain
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.rx.notification(Notification.Name(rawValue: "safariControllerNotificationName")).bind { notification in
            guard let token = (notification.object as? URL)?.accessToken,
                  let id = (notification.object as? URL)?.accessId
                else { return }
            
            self.keychain.save(.token, info: token)
            self.keychain.save(.id, info: id)
            
            self.safariController?.dismiss(animated: true, completion: {
                self.router?.route(to: .friendList(id: Int(id) ?? 1))
            })
        }.disposed(by: disposeBag)
        
        loginButton.radius(radius: 5)
        loginButton.rx.tap.subscribe { [weak self] _ in
            guard let url = URL(string: VKConstants.url) else {return}
            
            self?.safariController = SFSafariViewController(url: url)
            self?.safariController?.delegate = self
            
            guard let safariController = self?.safariController else {return}
            self?.present(safariController, animated: true, completion: nil)
        }.disposed(by: disposeBag)
    }
}


extension AuthorizationViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
