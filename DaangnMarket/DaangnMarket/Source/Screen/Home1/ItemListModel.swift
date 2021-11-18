//
//  ItemListModel.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/11/18.
//

import Foundation

struct ItemListModel {
    private var data: [Item]?
    
    init() {
        self.data = [
            Item(itemImage: "img_product1", itemTitle: "바비브라운 립스틱", location: "성동구 행당제2동", uploadDate: "끌올 3분", itemPrice: "11,000"),
            Item(itemImage: "img_product2", itemTitle: "커버낫 후드티 M", location: "동대문구 휘경동", uploadDate: "1분", itemPrice: "45,000"),
            Item(itemImage: "img_product3", itemTitle: "홀로그램 조개 트레이", location: "동대문구 답십리동", uploadDate: "끌올 4분", itemPrice: "4,000"),
            Item(itemImage: "img_product4", itemTitle: "퍼플키스 폰조나 포토카드", location: "안암동", uploadDate: "2분", itemPrice: "3,000"),
            Item(itemImage: "img_product1", itemTitle: "바비브라운 립스틱", location: "성동구 행당제2동", uploadDate: "끌올 3분", itemPrice: "11,000"),
            Item(itemImage: "img_product2", itemTitle: "커버낫 후드티 M", location: "동대문구 휘경동", uploadDate: "1분", itemPrice: "45,000"),
            Item(itemImage: "img_product3", itemTitle: "홀로그램 조개 트레이", location: "동대문구 답십리동", uploadDate: "끌올 4분", itemPrice: "4,000"),
            Item(itemImage: "img_product4", itemTitle: "퍼플키스 폰조나 포토카드", location: "안암동", uploadDate: "2분", itemPrice: "3,000"),
            Item(itemImage: "img_product1", itemTitle: "바비브라운 립스틱", location: "성동구 행당제2동", uploadDate: "끌올 3분", itemPrice: "11,000"),
            Item(itemImage: "img_product2", itemTitle: "커버낫 후드티 M", location: "동대문구 휘경동", uploadDate: "1분", itemPrice: "45,000"),
            Item(itemImage: "img_product3", itemTitle: "홀로그램 조개 트레이", location: "동대문구 답십리동", uploadDate: "끌올 4분", itemPrice: "4,000"),
            Item(itemImage: "img_product4", itemTitle: "퍼플키스 폰조나 포토카드", location: "안암동", uploadDate: "2분", itemPrice: "3,000")
        ]
    }
    
    public func getItemListModel() -> [Item] {
        return data ?? []
    }
    
}
