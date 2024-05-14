

import Foundation


struct GroceryPhotoModel: Identifiable {
    let id: Int
    let photoURL:String
    let groceryId:Int?
    
    init(id: Int, photoURL: String, groceryId: Int? = nil) {
            self.id = id
            self.photoURL = photoURL
            self.groceryId = groceryId
        }
}
