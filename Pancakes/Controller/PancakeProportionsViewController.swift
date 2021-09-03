//
//  ViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 28/08/2021.
//

import UIKit

class PancakeProportionsViewController: UIViewController {
    
    @IBOutlet weak var flourLabel: UILabel!
    @IBOutlet weak var eggsLabel: UILabel!
    @IBOutlet weak var milkLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var saltLabel: UILabel!
    @IBOutlet weak var oilLabel: UILabel!
    
    @IBOutlet weak var pancakeNumberLabel: UILabel!
    @IBOutlet weak var mesurementSegmentControl: UISegmentedControl!
    
    
    @IBOutlet weak var pancakeSlider: UISlider!{
        didSet{
            pancakeSlider.maximumValue = 24
            pancakeSlider.minimumValue = 0
            pancakeSlider.value = 8
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Calculate pancake measurements!"
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
        print("pancakes", pancakeSlider.value)
        updateLabelsForSlider(value: pancakeSlider.value)
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        updateLabelsForSlider(value: pancakeSlider.value)
    }
    
    
    func updateLabelsForSlider (value:Float){
        //assigning values for labels based on picked segment
        
        
        let pancakeCount = Int(value)
        pancakeNumberLabel.text = "\(pancakeCount) pancakes"
        var flourString = ""
        var eggString = ""
        var milkString = ""
        var waterString = ""
        var sugarString = ""
        var saltString = ""
        var oilString = ""
        
        switch mesurementSegmentControl.selectedSegmentIndex {
        case 0:
            flourString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).flour) + " cups"
            eggString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).eggs)
            milkString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).milk) + " cups"
            waterString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).water) + " cups"
            sugarString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).sugar) + " tbsp."
            saltString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).salt) + " tsp."
            oilString = String(format: "%.1F", convertIngredientsFromCups(pancakeCount: pancakeCount).oil) + " tbsp."
        default:
            flourString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).flour) + " grams"
            eggString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).eggs)
            milkString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).milk) + " grams"
            waterString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).water) + " grams"
            sugarString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).sugar) + " grams"
            saltString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).salt) + " grams"
            oilString = String(format: "%.1F", convertIngredientsFromGrams(pancakeCount: pancakeCount).oil) + " grams"
        }
        flourLabel.text = flourString
        eggsLabel.text = eggString
        milkLabel.text = milkString
        waterLabel.text = waterString
        sugarLabel.text = sugarString
        saltLabel.text = saltString
        oilLabel.text = oilString
        
    }
    
    
    
    
    
    func convertIngredientsFromCups(pancakeCount: Int) -> (flour: Double, eggs: Double, milk: Double, water: Double, sugar: Double, salt: Double, oil:Double){
        //converts into cups proportionally
        let flour = (Double(pancakeCount)/8*1.5)
        let eggs = (Double(pancakeCount)/8*2)
        let milk = (Double(pancakeCount)/8)
        let water = (Double(pancakeCount)/8)
        let sugar = (Double(pancakeCount)/8*2)
        let salt = (Double(pancakeCount)/8*0.5)
        let oil = (Double(pancakeCount)/8*2)
        
        
        return (flour, eggs, milk, water, sugar, salt, oil)
    }
    
    func convertIngredientsFromGrams(pancakeCount: Int) -> (flour: Double, eggs: Double, milk: Double, water: Double, sugar: Double, salt: Double, oil:Double){
        // first converts to cups and then assings specific weight to each material
        //eggs have the same calculation because they do not come in cups but as a whole
        let flour = (Double(pancakeCount)/8*1.5*160)
        let eggs = (Double(pancakeCount)/8*2)
        let milk = (Double(pancakeCount)/8*240)
        let water = (Double(pancakeCount)/8*250)
        let sugar = (Double(pancakeCount)/8*2*25)
        let salt = (Double(pancakeCount)/8*0.5*10)
        let oil = (Double(pancakeCount)/8*2*17)
        
        
        return (flour, eggs, milk, water, sugar, salt, oil)
    }
    
    
    @IBAction func infoButtonTapped(_ sender: Any) {
        basicAlert(title: "Calculate materials", message: "By using the slider you can see how much of baking materials you will need for tasty pancakes. To change measurements, click on the specific segment below.")
    }
    
    
}




