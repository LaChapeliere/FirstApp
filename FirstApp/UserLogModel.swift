//
//  UserLogModel.swift
//  FirstApp
//
//  Created by Emma Barme on 16/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import Foundation

class UserLogModel {
    
    var defaults: NSUserDefaults? = NSUserDefaults.standardUserDefaults()
    private let keyForPasswords = "keyForPasswords"
    private let keyForData = "keyForData"
    
    var currentUser: String?
    
    init() {}
    
    func fetchPasswords () -> [String: String]? {
        if let passwords = defaults!.dictionaryForKey(keyForPasswords) as? [String: String] {
            return passwords
        }
        return nil
    }
    
    func fetchData () -> [String: [String]]? {
        if let data = defaults?.dictionaryForKey(keyForData) as? [String: [String]]
        {
            return data
        }
        return nil
    }
    
    func addUser (name: String, password: String) -> Bool {
        if (name == "" || password == "")
        {
            return true;
        }
        
        var passwordsDic = [String: String]()
        if let passwords = fetchPasswords() {
            passwordsDic = passwords
            if passwordsDic[name] != nil {
                return false
            }
            passwordsDic[name] = password
        }
        else {
            passwordsDic = [name: password]
        }

        defaults?.setObject(passwordsDic, forKey: keyForPasswords)
        
        var dataDic = [String: [String]]()
        if let data = fetchData() {
            dataDic = data
        }
        dataDic[name] = [String]()
        defaults?.setObject(dataDic, forKey: keyForData)
        
        return true
    }
    
    func logInUser (name: String, password: String) -> String? {
        let passwords = fetchPasswords()
        if passwords == nil {
            return "Unknown user"
        }
        
        let fetchedPassword = passwords![name]
        if fetchedPassword == nil {
            return "Unknown user"
        }
        if fetchedPassword == password {
            return nil
        }
        else {
            return "Wrong password"
        }
    }
    
    func addData (name: String, data: [String]) -> Bool {
        if data == [""] {
            return false
        }
        
        let passwords = fetchPasswords()
        if passwords == nil {
            return false
        }
        let fetchedPassword = passwords![name]
        if fetchedPassword == nil {
            return false
        }
        
        var dataDic = [String: [String]]()
        if let fetchedData = fetchData() {
            dataDic = fetchedData
            if let userData = dataDic[name] {
                dataDic[name] = userData + data
            }
            else {
                return false
            }
        }
        else {
            return false
        }
        
        defaults?.setObject(dataDic, forKey: keyForData)
        return true;
    }
    
    func clearData (name: String) -> Bool {
        
        if let fetchedData = fetchData() {
            var dataDic = fetchedData
            if dataDic[name] != nil {
                dataDic[name] = []
                defaults?.setObject(dataDic, forKey: keyForData)
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
}