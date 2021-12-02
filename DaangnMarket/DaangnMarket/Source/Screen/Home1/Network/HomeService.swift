//
//  HomeService.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/02.
//

import Foundation

import Moya

enum HomeService {
    case getItemData
}

extension HomeService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .getItemData:
            return "/post"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getItemData:
            return .get
        }
    }

    var task: Task {
        switch self{
        case .getItemData:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }


}
