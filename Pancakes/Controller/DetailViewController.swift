//
//  DetailViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 30/08/2021.
//

import UIKit
import Alamofire
import SwiftyJSON


class DetailViewController: UIViewController {
        
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
            webURLString = String(urlResult)
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
        getURL(url: "https://api.spoonacular.com/recipes/\(id)/information", params: params)
    }
    

    //#warning("App crashes and does not go to web view with reason (unrecognized sender)" )
    @IBAction func goToWebTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(identifier: "WebViewController") as? WebViewController else {
            return
        }
            
        vc.urlString = webURLString
        

    //       present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
   
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination: WebViewController = segue.destination as! WebViewController
//        //getURL(url: "https://api.spoonacular.com/recipes/\(id)/information", params: params)
//        destination.urlString = "https://www.foodista.com/recipe/RHSMN38H/pancake-bites"
//    }
    
}
