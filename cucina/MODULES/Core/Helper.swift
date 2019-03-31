//
//  Helper.swift
//  cucina
//
//  Created by Manisha on 25/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//

import Foundation


public func readDataFromJson<T>(fileName: String) -> T? {
    let fileName = "landing"
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [AnyObject]

            if let jsonResult = jsonResult as? [LandingDataModel] {
                print("jsonResult \(jsonResult)")
            }

            let jsonResponse = try JSONDecoder().decode([LandingDataModel].self, from: data)
            print("jsonResponse \(jsonResponse)")
            return jsonResponse as? T
        } catch {
            // handle error
        }
    }
    return nil
}
