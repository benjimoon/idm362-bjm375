//
//  DetailsViewController.swift
//  idm362-bjm375
//
//  Created by Benji Moon on 3/14/23.
//

import UIKit

class DetailsViewController: UIViewController {

    var ndxNum:Int?
    var incomingName:String?
    
    
    @IBOutlet weak var bigName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        
        bigName.text = incomingName?.uppercased()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
