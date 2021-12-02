//
//  HomeItemData.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/02.
//

import Foundation

// MARK: - Item
struct HomeItem: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [HomeItemData]
}

// MARK: - Datum
struct HomeItemData: Codable {
    let id: Int
    let img: String
    let title, category: String
    let price: Int
    let state, trade, content: String
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
