//
//  DetailViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 30/08/2021.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON


class DetailViewController: UIViewController {
    
    
    //var savedItems = [Recipes]()
    var context: NSManagedObjectContext?
    
    var webURLString = String()
    var titleString = String()
    var newsImage: UIImage?
    var id : Int = 0
    let params: [String:String] = ["apiKey": "235748490c7b4875a69d3e30501d9e5d"]
    
    
    
    func getURL(url: String, params:[String:String]){
    AF.request(url, method: .get, parameters: params).responseJSON {response in
        if response.value != nil{
            let detailJSON: JSON = JSON(response.value!)
            //print("detailJSON ", detailJSON)
            self.updateURL(json: detailJSON)
        }else{
            self.basicAlert(title: "Something went wrong", message: "Try again with a different recipe")
        }
        
    }
    }
    
    func updateURL(json: JSON){
        if let urlResult = json["sourceUrl"].string{
            webURLString = urlResult
            print(urlResult)
        }else{
            self.basicAlert(title: "Something went wrong", message: "Try again with a different recipe")
        }
    }
    
    @IBOutlet weak var recipeDetailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeDetailTitleLabel.text = titleString
        detailImageView.image = newsImage
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        getURL(url: "https://api.spoonacular.com/recipes/\(id)/information", params: params)
    }
    

   
    @IBAction func goToWebView(_ sender: Any) {
    }
    
    @IBAction func saveToFavoritesTapped(_ sender: Any) {
    }
    
    
}
