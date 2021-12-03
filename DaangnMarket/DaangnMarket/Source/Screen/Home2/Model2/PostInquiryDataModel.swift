//
//  PostInquiryDataModel.swift
//  DaangnMarket
//
//  Created by 조양원 on 2021/12/01.
//

import Foundation

// MARK: - wiWelcome
struct PostInquiryDataModel: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ProductDetailData]
}

// MARK: - wiDatum
struct ProductDetailData: Codable {
    let id: Int
    let img: String
    let title, category: String
    let price: Int
    let state: String
    let trade: String
    let content: String
    let isDeleted: Bool
    let createdAt: String
    let userID: Int
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, img, title, category, price, state, trade, content, isDeleted, createdAt
        case userID = "userId"
        case address
    }
}
// enum ProductStatus: String, Codable {
//    case 상태양호 = "상태양호"
//    case 중고 = "중고"
// }
//
// enum TradeStatus: String, Codable {
//    case 대면 = "대면"
//    case 택배 = "택배"
// }
