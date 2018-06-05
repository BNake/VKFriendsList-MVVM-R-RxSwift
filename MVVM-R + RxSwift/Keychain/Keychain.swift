//
//  Keychain.swift
//  MVVM-R + RxSwift
//
//  Created by Захар Бабкин on 05/06/2018.
//  Copyright © 2018 Захар Бабкин. All rights reserved.
//

import Foundation
import Security

fileprivate let userAccount = "AuthenticatedUser"

fileprivate let tokenKey = "KeyForToken"
fileprivate let iDKey = "KeyForId"


fileprivate let kSecClassValue = NSString(format: kSecClass)
fileprivate let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
fileprivate let kSecValueDataValue = NSString(format: kSecValueData)
fileprivate let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
fileprivate let kSecAttrServiceValue = NSString(format: kSecAttrService)
fileprivate let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
fileprivate let kSecReturnDataValue = NSString(format: kSecReturnData)
fileprivate let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)


class Keychain {
    
    enum AuthInfoType {
        case token
        case id
    }
    
    func save(_ authInfoType: AuthInfoType, info: String ) {
        switch authInfoType {
        case .token:     self.save(service: tokenKey, data: info)
        case .id:  self.save(service: iDKey, data: info)
        }
    }
    
    func load(_ authInfoType: AuthInfoType) -> String? {
        switch authInfoType {
        case .token:     return self.load(service: tokenKey)
        case .id:  return self.load(service: iDKey)
        }
    }
    
    private func save(service: String, data: String) {
        guard let dataFromString = data.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false) else {return}
        
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        SecItemDelete(keychainQuery as CFDictionary)
        
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    private func load(service: String) -> String? {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = String(data: retrievedData as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
            }
        }
        
        return contentsOfKeychain
    }
}
