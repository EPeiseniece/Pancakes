//
//  RecipeFeedViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 29/08/2021.
//

import UIKit
import Gloss



class RecipeFeedViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [RecipeModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        handleGetData()

        // Do any additional setup after loading the view.
    }
    

   

    func handleGetData(){
        let jsonUrl = "https://api.spoonacular.com/recipes/complexSearch?query=pancake&number=25&apiKey=235748490c7b4875a69d3e30501d9e5d"
        
        guard let url = URL(string: jsonUrl) else {return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, err in
            if let err = err {
                self.basicAlert(title: "Error!", message: "\(err.localizedDescription)")
        }
            guard let data = data else {
                self.basicAlert(title: "Error!", message: "Something went wrong, no data.")
                return
            }
                do{
                    if let dictData = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print("dictData", dictData)
                        self.populateData(dictData)
                    }
                }catch{
                        
                    }

        }
        
        task.resume()
        
    }
    
    func populateData(_ dict: [String:Any]){
        guard let responseDict = dict["results"] as? [Gloss.JSON] else {
            return
        }
        recipes = [RecipeModel].from(jsonArray: responseDict) ?? []
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    
}
}
    
    extension RecipeFeedViewController: UITableViewDelegate, UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipes.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeTableViewCell else{
                return UITableViewCell()
            }
            let recipe = recipes[indexPath.row]
            cell.recipeTitleLabel.text = recipe.title
            cell.recipeTitleLabel.numberOfLines = 0
            
            if let image = recipe.image{
                cell.recipeImageView.image = image
            }
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
    
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    guard let vc = storyboard.instantiateViewController(identifier: "WebViewController") as? WebViewController else {
        return
    }
//        let item = items[indexPath.row]
//        vc.contentString = item.desciption
//        vc.titleString = item.title
//        vc.webURLString = item.url
//        vc.newsImage = item.image

//       present(vc, animated: true, completion: nil)
    navigationController?.pushViewController(vc, animated: true)
}
    
    
    
    
    
}
