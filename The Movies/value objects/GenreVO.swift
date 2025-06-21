//
//  GenreVO.swift
//  The Movies
//
//  Created by PaingHtet on 21/06/2025.
//

import Foundation

class GenreVO {
    
    var genreName: String
    var isSelected: Bool = false
    
    init(genreName: String, isSelected: Bool) {
        self.genreName = genreName
        self.isSelected = isSelected
    }
    
}
