//
//  JSONParamterEncoder.swift
//  cucina
//
//  Created by Manisha on 21/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
}

//extension Encodable {
//    public var dictionary: [String: Any]? {
//        guard let data = try? JSONEncoder().encode(self) else {
//            return nil
//        }
//        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
//    }
//
//    public var array: [Any]? {
//        guard let data = try? JSONEncoder().encode(self) else {
//            return nil
//        }
//        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [Any] }
//    }
//}
