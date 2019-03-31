//
//  EndPointType.swift
//  cucina
//
//  Created by Manisha on 21/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//

import Foundation
import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
