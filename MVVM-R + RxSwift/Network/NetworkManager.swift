//
//  NetworkManager.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 02/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import RxSwift

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    let router = NetRouter<VKApi>()
    
    func getFriends(id: Int) -> Observable<[Friend]>{
        return Observable<[Friend]>.create { observable in
            self.router.request(.getFriends(id: id)) { (data, response, error) in
                guard error == nil else { observable.onError("Please check your network connection." as! Error); return }
                guard let response = response as? HTTPURLResponse else { observable.onError("Fail create response" as! Error); return }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { observable.onError(NetworkResponse.noData.rawValue as! Error); return }
                    do {
                        let apiResponse = try JSONDecoder().decode(FriendResponse.self, from: responseData)
                        if let errorResponse = apiResponse.error{
                            guard let errorMsg = errorResponse.errorMsg else { return }
                            observable.onError(errorMsg as! Error)
                        }else{
                            observable.onNext((apiResponse.response?.items)!)
                        }
                    }catch {
                        observable.onError(NetworkResponse.unableToDecode.rawValue as! Error)
                    }
                case .failure(let networkFailureError):
                    observable.onError(networkFailureError as! Error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func getProfile(id: Int) -> Observable<[Profile]> {
        return Observable<[Profile]>.create { observable in
            self.router.request(.getProfile(id: id)) { (data, response, error) in
                guard error == nil else { observable.onError("Please check your network connection." as! Error); return }
                guard let response = response as? HTTPURLResponse else { observable.onError("Fail create response" as! Error); return }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { observable.onError(NetworkResponse.noData.rawValue as! Error); return }
                    do {
                        let apiResponse = try JSONDecoder().decode(ProfileResponde.self, from: responseData)
                        if let errorResponse = apiResponse.error{
                            guard let errorMsg = errorResponse.errorMsg else { return }
                            observable.onError(errorMsg as! Error)
                        }else{
                            observable.onNext((apiResponse.response)!)
                        }
                    }catch {
                        observable.onError(NetworkResponse.unableToDecode.rawValue as! Error)
                    }
                case .failure(let networkFailureError):
                    observable.onError(networkFailureError as! Error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func getFeed(id: Int) -> Observable<[Feed]> {
        return Observable<[Feed]>.create { observable in
            self.router.request(.getFeed(id: id)) { (data, response, error) in
                guard error == nil else { observable.onError("Please check your network connection." as! Error); return }
                guard let response = response as? HTTPURLResponse else { observable.onError("Fail create response" as! Error); return }
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else { observable.onError(NetworkResponse.noData.rawValue as! Error); return }
                    do {
                        let apiResponse = try JSONDecoder().decode(FeedResponse.self, from: responseData)
                        if let errorResponse = apiResponse.error{
                            guard let errorMsg = errorResponse.errorMsg else { return }
                            observable.onError(errorMsg as! Error)
                        }else{
                            observable.onNext((apiResponse.response?.items)!)
                        }
                    }catch {
                        observable.onError(NetworkResponse.unableToDecode.rawValue as! Error)
                    }
                case .failure(let networkFailureError):
                    observable.onError(networkFailureError as! Error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
