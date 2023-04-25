//
//  PostModel.swift
//  Navigation
//
//  Created by My Air on 22.12.2022.
//

import Foundation
import UIKit

struct Post {
    var author, image, description: String
    var views: Int
}

struct PostModel {
    
    static var post = [Post(author: "Sergio Ramos",
                     image: "эльбрус",
                     description: "Горы России: Эльбрус. Высочайшая точка Европы - 5642 метра над уровнем моря",
                     views: 0),
                Post(author: "Странник",
                     image: "дагестан",
                     description: "Дагестан - наивысшая точка Базардюзю, расположена на уровне 4466 метров над уровнем моря",
                     views: 0),
                Post(author: "СевКавТВ",
                     image: "машук",
                     description: "Гора Машук в Пятигорске",
                     views: 0),
                Post(author: "Freerider",
                     image: "аибга",
                     description: "Горный хребет Аибга в Красной поляне - мекка для российских фрирайдеров из-за особых кондиций снега. Наивысшая точка - Черная Пирамида, расположена на высоте 2375 метров над уровнем моря",
                     views: 0),
                Post(author: "Путешественник",
                     image: "алтай",
                     description: "Лучше гор могут быть горы, на которых ещё не бывал - Алтай",
                     views: 0)]
}

struct Model {
    static let photos = [UIImage(named: "1"),
                         UIImage(named: "2"),
                         UIImage(named: "3"),
                         UIImage(named: "4"),
                         UIImage(named: "5"),
                         UIImage(named: "6"),
                         UIImage(named: "7"),
                         UIImage(named: "8"),
                         UIImage(named: "9"),
                         UIImage(named: "10"),
                         UIImage(named: "11"),
                         UIImage(named: "12"),
                         UIImage(named: "13"),
                         UIImage(named: "14"),
                         UIImage(named: "15"),
                         UIImage(named: "16"),
                         UIImage(named: "17"),
                         UIImage(named: "18"),
                         UIImage(named: "19"),
                         UIImage(named: "20")
    ]
    
    static let photoGallery = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"]
}
