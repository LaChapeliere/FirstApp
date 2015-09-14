//
//  GraphingModel.swift
//  FirstApp
//
//  Created by Emma Barme on 14/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import Foundation

class GraphingModel {
    private var data = [Int]()
    
    func addValue(newValue: Int) {
        data.append(newValue)
    }
    
    func accessRawData () -> [Int] {
        return data
    }
}