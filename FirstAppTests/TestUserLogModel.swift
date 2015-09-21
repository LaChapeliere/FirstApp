//
//  TestUserLogModel.swift
//  FirstApp
//
//  Created by Emma Barme on 16/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit
import XCTest

class TestUserLogModel: XCTestCase {

    var userLogModel: UserLogModel!
    
    override func setUp () {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        userLogModel = UserLogModel()
        
        class MockUserDefaults: NSUserDefaults {
            var info = [String: AnyObject]()

            override func setObject(value: AnyObject?, forKey defaultName: String) {
                if value != nil {
                    info[defaultName] = value!
                }
            }
            
            override func dictionaryForKey(defaultName: String) -> [NSObject : AnyObject]? {
                let dic = info[defaultName] as? [NSObject : AnyObject]
                return dic
            }
        }
        
        userLogModel.defaults = MockUserDefaults()
    }
    
    override func tearDown () {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample () {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testFetchPasswordsReturnsNilIfNone () {
        let dic = userLogModel.fetchPasswords()
        XCTAssertNil(dic, "UserLogModel.fetchPasswords should return nil when no password have been set up")
    }
    
    func testFetchPasswordsReturnsDic () {
        userLogModel.defaults?.setObject(["username":"password"], forKey: "keyForPasswords")
        let dic = userLogModel.fetchPasswords()
        XCTAssertNotNil(dic, "UserLogModel.fetchPasswords should not return nil when a passwords dic is present")
        if dic != nil {
            XCTAssertEqual(dic!, ["username":"password"], "UserLogModel.fetchPasswords should return the passwords dic")
        }
    }
    
    func testFetchPasswordsReturnsNilIfWrongType () {
        userLogModel.defaults?.setObject("Hello", forKey: "keyForPasswords")
        let dic = userLogModel.fetchPasswords()
        XCTAssertNil(dic, "UserLogModel.fetchPasswords should return nil when no password have been set up")
    }
    
    func testFetchData () {
        var data = userLogModel.fetchData()
        XCTAssertNil(data, "UserLogModel.fetchData should return nil when no data have been set up")
        
        userLogModel.defaults?.setObject(["username":["Hello", "world"]], forKey: "keyForData")
        
        data = userLogModel.fetchData()
        XCTAssertNotNil(data, "UserLogModel.fetchData should not return nil when data is present")
        if data != nil {
            XCTAssertEqual(data!, ["username":["Hello", "world"]], "UserLogModel.fetchData should return the data")
        }
    }
    
    func testAddUserPasswords () {
        let name = "NAME"
        let password = "PASSWORD"
        let nameBis = "NAMEBIS"
        let passwordBis = "PASSWORDBIS"
        
        var overwrite = userLogModel.addUser(name, password: password)
        XCTAssertTrue(overwrite, "UserLogModel.addUser should return true when adding password with unknown username key")
        
        var passwordsDic = userLogModel.fetchPasswords()
        XCTAssertNotNil(passwordsDic, "UserLogModel.addUser should store the username/password couples")
        if (passwordsDic != nil)
        {
            let fetchedPassword: String? = passwordsDic?[name]
            XCTAssertNotNil(fetchedPassword, "UserLogModel.addUser should store the correct password for username")
            if fetchedPassword != nil {
                XCTAssertEqual(fetchedPassword!, password, "UserLogModel.addUser should store the correct password for username")
            }
        }
        
        overwrite = userLogModel.addUser(nameBis, password: passwordBis)
        XCTAssertTrue(overwrite, "UserLogModel.addUser should return true when adding password with unknown username key")
        passwordsDic = userLogModel.fetchPasswords()
        XCTAssertNotNil(passwordsDic, "UserLogModel.addUser should store the username/password couples")
        if (passwordsDic != nil)
        {
            var fetchedPassword: String? = passwordsDic?[name]
            XCTAssertNotNil(fetchedPassword, "UserLogModel.addUser should not delete previous users when adding new one")
            if fetchedPassword != nil {
                XCTAssertEqual(fetchedPassword!, password, "UserLogModel.addUser should not delete previous users when adding new one")
            }
            fetchedPassword = passwordsDic?[nameBis]
            XCTAssertNotNil(fetchedPassword, "UserLogModel.addUser should store the correct password for username")
            if fetchedPassword != nil {
                XCTAssertEqual(fetchedPassword!, passwordBis, "UserLogModel.addUser should store the correct password for username")
            }
        }
        
        overwrite = userLogModel.addUser(name, password: passwordBis)
        XCTAssertFalse(overwrite, "UserLogModel.addUser should return false when trying to add password for already existing username")
        passwordsDic = userLogModel.fetchPasswords()
        if (passwordsDic != nil)
        {
            let fetchedPassword: String? = passwordsDic?[name]
            if fetchedPassword != nil {
                XCTAssertEqual(fetchedPassword!, password, "UserLogModel.addUser should not overwrite the password for a given username key")
            }
        }
        
        overwrite = userLogModel.addUser("", password: "Hello")
        XCTAssertTrue(overwrite, "UserLogModel.addUser should return true when empty input")
        overwrite = userLogModel.addUser("Hello", password: "")
        XCTAssertTrue(overwrite, "UserLogModel.addUser should return true when empty input")
        let newPasswordsDic = userLogModel.fetchPasswords()
        if passwordsDic != nil && newPasswordsDic != nil {
            XCTAssertEqual(passwordsDic!, newPasswordsDic!, "UserLogModel.addUser should not modify defaults when empty input")
        }
    }
    
    func testAddUserData () {
        let knownName = "Name"
        let otherName = "Eman"
        let knownNamePassword = "Password"
        let otherNamePassword = "Drowssap"
        
        userLogModel.addUser(knownName, password: knownNamePassword)
        
        var data = userLogModel.fetchData()
        XCTAssertNotNil(data, "UserLogModel.addUser should have data for known users")
        if (data != nil)
        {
            let fetchedData: [String]? = data![knownName]
            XCTAssertNotNil(fetchedData, "UserLogModel.addUser should create a data list for the user")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, [String](), "UserLogModel.addUser should create an empty data list for the user")
                data![knownName] = ["DATA"]
                userLogModel.defaults?.setObject(data, forKey: "keyForData")
            }
        }
        
        userLogModel.addUser(otherName, password: otherNamePassword)

        data = userLogModel.fetchData()
        XCTAssertNotNil(data, "UserLogModel.addUser should have data for known users")
        if (data != nil)
        {
            var fetchedData: [String]? = data![knownName]
            XCTAssertNotNil(fetchedData, "UserLogModel.addUser should not delete previous data when adding new one")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, ["DATA"], "UserLogModel.addUser should not change previous data when adding new one")
            }
            fetchedData = data![otherName]
            XCTAssertNotNil(fetchedData, "UserLogModel.addUser should create a data list for the user")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, [String](), "UserLogModel.addUser should create an empty data list for the user")
            }
        }
        
        userLogModel.addUser(knownName, password: otherNamePassword)
        data = userLogModel.fetchData()
        XCTAssertNotNil(data, "UserLogModel.addUser should have data for known users")
        if (data != nil)
        {
            let fetchedData: [String]? = data![knownName]
            XCTAssertNotNil(fetchedData, "UserLogModel.addUser should not delete previous data when invalid add")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, ["DATA"], "UserLogModel.addUser should not change previous data when invalid add")
            }
        }
        
        userLogModel.addUser(knownName, password: "")
        data = userLogModel.fetchData()
        XCTAssertNotNil(data, "UserLogModel.addUser should have data for known users")
        if (data != nil)
        {
            let fetchedData: [String]? = data![knownName]
            XCTAssertNotNil(fetchedData, "UserLogModel.addUser should not delete previous data when empty input")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, ["DATA"], "UserLogModel.addUser should not change previous data when empty input")
            }
        }
    }
    
    func testLogInUser () {
        let knownName = "Name"
        let knownNamePassword = "Password"
        let wrongPassword = "0000"
        let wrongUser = "Anonymous"
        
        var log = userLogModel.logInUser(knownName, password: knownNamePassword)
        XCTAssertNotNil(log, "UserLogModel.logInUser() should return error message Unknown user when the password dic is empty")
        if log != nil {
            XCTAssertEqual(log!, "Unknown user", "UserLogModel.logInUser() should return error message Unknown user when the password dic is empty")
        }
        
        userLogModel.defaults?.setObject([knownName: knownNamePassword], forKey: "keyForPasswords")
        
        log = userLogModel.logInUser(knownName, password: knownNamePassword)
        XCTAssertNil(log, "UserLogModel.logInUser() should return nil (no error message) when the username-password couple exists")
        
        log = userLogModel.logInUser(wrongUser, password: knownNamePassword)
        if log != nil {
            XCTAssertEqual(log!, "Unknown user", "UserLogModel.logInUser() should return error message Unknown user when the user is not registered")
        }
        
        log = userLogModel.logInUser(knownName, password: wrongPassword)
        if log != nil {
            XCTAssertEqual(log!, "Wrong password", "UserLogModel.logInUser() should return error message Wrong password when the user is not registered")
        }
    }
    
    func testAddData () {
        let name = "Name"
        let password = "Password"
        let data = ["Hello", "world"]
        let otherName = "Eman"
        let otherPassword = "Drowssap"
        let otherData = ["Tic"]
        let moreData = ["Tac"]
        
        userLogModel.addUser(name, password: password)
        var added = userLogModel.addData(name, data: data)
        XCTAssertTrue(added, "UserLogModel.addData should return true when data has been added")
        var dataDic = userLogModel.fetchData()
        if (dataDic != nil) {
            let fetchedData: [String]? = dataDic![name]
            XCTAssertNotNil(fetchedData, "UserLogModel.addData should not store an empty dataset")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, data, "UserLogModel.addData should add the provided data to the user key")
            }
        }
        
        added = userLogModel.addData(otherName, data: otherData)
        XCTAssertFalse(added, "UserLogModel.addData should return false when trying to add data for unknown user")
        if let otherDataDic = userLogModel.fetchData() {
            if dataDic != nil {
                XCTAssertEqual(otherDataDic[name]!, dataDic![name]!, "UserLogModel.addData should no modify data when trying to add data for unknown user")
            }
        }
        
        added = userLogModel.addData(name, data: moreData)
        XCTAssertTrue(added, "UserLogModel.addData should return true when data has been added")
        dataDic = userLogModel.fetchData()
        if (dataDic != nil) {
            let fetchedData: [String]? = dataDic![name]
            XCTAssertNotNil(fetchedData, "UserLogModel.addData should not store an empty dataset when adding data for a correct user")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, data + moreData, "UserLogModel.addData should add the provided data to the user key, and not delete previous data")
            }
        }
        
        userLogModel.addUser(otherName, password: otherPassword)
        added = userLogModel.addData(otherName, data: otherData)
        XCTAssertTrue(added, "UserLogModel.addData should return true when data has been added")
        dataDic = userLogModel.fetchData()
        if (dataDic != nil) {
            var fetchedData: [String]? = dataDic![otherName]
            XCTAssertNotNil(fetchedData, "UserLogModel.addData should not store an empty dataset when adding data for a correct user")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, otherData, "UserLogModel.addData should add the provided data to the user key")
            }
            fetchedData = dataDic![name]
            XCTAssertNotNil(fetchedData, "UserLogModel.addData should not store an empty dataset when adding data for a correct user")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, data + moreData, "UserLogModel.addData should add the provided data to the user key, and not delete previous data")
            }
        }

        added = userLogModel.addData(otherName, data: [""])
        XCTAssertFalse(added, "UserLogModel.addData should return false when trying to add empty data")
        if let otherDataDic = userLogModel.fetchData() {
            if dataDic != nil {
                XCTAssertEqual(otherDataDic[otherName]!, dataDic![otherName]!, "UserLogModel.addData should not modify data when trying to add empty data")
            }
        }
        
    }
    
    func testClearData () {
        let name = "Name"
        let password = "Password"
        let otherName = "Eman"
        let otherPassword = "Drowssap"
        let data = ["Hello", "world"]
        let otherData = ["Tic", "Tac"]
        let wrongName = "Fake"
        
        userLogModel.addUser(name, password: password)
        userLogModel.addData(name, data: data)
        
        var cleared = userLogModel.clearData(otherName)
        XCTAssertFalse(cleared, "UserLogModel.clearData() should return false when input is an unknown user")
        var dataDic = userLogModel.fetchData()
        if dataDic != nil {
            let fetchedData = dataDic![name]
            XCTAssertNotNil(fetchedData, "UserLogModel.clearData() should not delete data entries")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, data, "UserLogModel.clearData() should not modify data when input is an unknown user")
            }
        }
        
        userLogModel.addUser(otherName, password: otherPassword)
        userLogModel.addData(otherName, data: otherData)
        
        cleared = userLogModel.clearData(name)
        XCTAssertTrue(cleared, "UserLogModel.clearData() should return true when cleaning data of a known user")
        dataDic = userLogModel.fetchData()
        if dataDic != nil {
            var fetchedData = dataDic![name]
            XCTAssertNotNil(fetchedData, "UserLogModel.clearData() should not delete data entries")
            if fetchedData != nil {
            XCTAssertEqual(fetchedData!, [String](), "UserLogModel.clearData() should replace data for the provided user by an empty list")
            }
            fetchedData = dataDic![otherName]
            XCTAssertNotNil(fetchedData, "UserLogModel.clearData() should not delete data entries")
            if fetchedData != nil {
                XCTAssertEqual(fetchedData!, otherData, "UserLogModel.clearData() should not modify data for other users")
            }
        }
    }
}
