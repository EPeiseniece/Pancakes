//
//  AppearanceViewController.swift
//  Pancakes
//
//  Created by elina.peiseniece on 03/09/2021.
//

import UIKit

class AppearanceViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabelText()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func closebuttonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func openSettingsTapped(_ sender: Any) {
        openSettings()
    }
    
    func setLabelText(){
        var text = "Unable to specify UI style"
        if traitCollection.userInterfaceStyle == .dark{
            text = "Dark Mode is On\n Go to settings if you like \n to change to light mode"
        }else{
            text = "Light Mode is On\n Go to settings if you like \n to change to dark mode"
        }
        textLabel.text = text
        
    }
    
    
    func openSettings(){
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsURL){
            UIApplication.shared.open(settingsURL, options: [:]) { success in
                print("success: ",success)
            }
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setLabelText()
    }
}
