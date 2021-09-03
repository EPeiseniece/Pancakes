//
//  DetailViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 30/08/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData


class DetailViewController: UIViewController {
    
    var savedData = [Items]()
    var context: NSManagedObjectContext!
        
    var webURLString = String()
    var titleString = String()
    var newsImage: UIImage?
    var id : Int = 0
    var detailtext = String()
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
            webURLString = String(urlResult)
            if let readyText = json["summary"].string{
                detailtext = readyText
            }else{
                self.basicAlert(title: "Something went wrong", message: "Try again with a different recipe")
            }
            print(urlResult)
            print(detailtext)
        }else{
            self.basicAlert(title: "Something went wrong", message: "Try again with a different recipe")
   
        }
        detailTextView.text = detailtext
    }
    
    @IBOutlet weak var recipeDetailTitleLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBAction func fullArticleButton(_ sender: Any) {
    }


    @IBOutlet weak var detailTextView: UITextView!
    
    

        
        
        override func viewDidLoad() {
                super.viewDidLoad()
                
                recipeDetailTitleLabel.text = titleString
                detailImageView.image = newsImage
                getURL(url: "https://api.spoonacular.com/recipes/\(id)/information", params: params)
            
            self.title = "Selected recipe"
            
        }
    
    

    


    @IBAction func goToWebTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebViewController") as? WebViewController else {
            return
        }
            
        vc.urlString = webURLString
        

    //       present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    


        
        
    }
    
   
    

    

