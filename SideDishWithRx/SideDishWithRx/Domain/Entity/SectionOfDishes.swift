//
//  SectionOfDishes.swift
//  SideDishWithRx
//
//  Created by 오킹 on 2022/02/28.
//

import Foundation
import RxDataSources

enum SectionOfDishes: CaseIterable {
    
    case main
    case soup
    case side
    
    var header: String {
        switch self {
        case .main: return "모두가 좋아하는 든든한 메인요리"
        case .soup: return "정성이 담긴 뜨끈뜨끈 국물요리"
        case .side: return "식탁을 풍성하게 하는 정갈한 밑반찬"
        }
    }
}
