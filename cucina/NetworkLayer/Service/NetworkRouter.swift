//
//  NetworkRouter.swift
//  cucina
//
//  Created by Manisha on 21/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//

import Foundation

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
