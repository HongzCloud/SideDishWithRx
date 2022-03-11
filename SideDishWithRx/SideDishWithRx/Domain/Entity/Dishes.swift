//
//  Dishes.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/26.
//

import Foundation

// MARK: - Dishes

struct Dishes: Codable {
    let statusCode: Int
    let body: [Dish]
}

// MARK: - Dish

struct Dish: Codable {
    let detailHash: String
    let image: String
    let alt: String
    let deliveryType: [DeliveryType]
    let title, bodyDescription: String
    let nPrice: String?
    let sPrice: String
    let badge: [BadgeType]?

    enum CodingKeys: String, CodingKey {
        case detailHash = "detail_hash"
        case image, alt
        case deliveryType = "delivery_type"
        case title
        case bodyDescription = "description"
        case nPrice = "n_price"
        case sPrice = "s_price"
        case badge
    }
}

enum DeliveryType: String, Codable {
    case dawnDelivery = "새벽배송"
    case nationalDelivery = "전국택배"
}

enum BadgeType: String, Codable {
    case event = "이벤트특가"
    case main = "메인특가"
    case launching = "런칭특가"
}
