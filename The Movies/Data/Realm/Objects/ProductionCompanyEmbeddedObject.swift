//
//  ProductionCompanyEmbeddedObject.swift
//  The Movies
//
//  Created by Paing Htet on 09/08/2025.
//

import RealmSwift

class ProductionCompanyEmbeddedObject: EmbeddedObject {
    
    @Persisted var id: Int?
    @Persisted var logoPath: String?
    @Persisted var name: String?
    @Persisted var originCountry: String?
    
    func convertToProductionCompany() -> ProductionCompany {
        ProductionCompany(id: id, logoPath: logoPath, name: name, originCountry: originCountry)
    }
    
}
