//
//  GenreVO.swift
//  The Movies
//
//  Created by Paing Htet on 02/08/2025.
//

import Foundation

class GenreVO {
    
    var id: Int
    var genreName: String
    var isSelected: Bool = false
    
    init(id: Int, genreName: String, isSelected: Bool) {
        self.id = id
        self.genreName = genreName
        self.isSelected = isSelected
    }
    
}
