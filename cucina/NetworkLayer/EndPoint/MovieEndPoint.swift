//
//  EndPointProtocol.swift
//  cucina
//
//  Created by Manisha on 21/03/19.
//  Copyright © 2019 Manisha. All rights reserved.
//
// Reference: https://medium.com/flawless-app-stories/writing-network-layer-in-swift-protocol-oriented-approach-4fa40ef1f908

import UIKit

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}

extension MovieApi: EndPointType {

    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }

    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }

    var httpMethod: HTTPMethod {
        return .GET
    }

    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}
