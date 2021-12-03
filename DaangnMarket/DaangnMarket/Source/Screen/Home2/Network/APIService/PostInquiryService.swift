//
//  PostInquiryService.swift
//  DaangnMarket
//
//  Created by 조양원 on 2021/12/01.
//

import Foundation

import Moya

enum PostInquiryService {
    case postInquiry
}

extension PostInquiryService: TargetType {

    var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .postInquiry:
            return "/post/"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var sampleData: Data {
        return "@@".data(using: .utf8)!
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return nil
    }

}
