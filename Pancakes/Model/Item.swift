//
//  Item.swift
//  Pancakes
//
//  Created by elina.peiseniece on 29/08/2021.
//

import Foundation
import UIKit
import Gloss

class RecipeModel: JSONDecodable{
    
    var id: Int?
    var title: String
    var image: UIImage?
    var urlToImage:String
    
    required init(json: JSON) {
        self.id = "id" <~~ json
        self.urlToImage = "image" <~~ json ?? ""
        self.title = "title" <~~ json ?? ""
        
        DispatchQueue.main.async {
            self.image = self.loadImage()
        }
    }

    private func loadImage() -> UIImage? {
        var returnImage: UIImage?

        guard let url = URL(string: urlToImage) else {
            return returnImage
        }
        if let data = try? Data(contentsOf: url){
            if let image = UIImage(data: data){
                returnImage = image
            }
        }
        return returnImage

    }
}
