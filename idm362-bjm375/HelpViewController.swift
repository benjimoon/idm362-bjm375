//
//  HelpViewController.swift
//  idm362-bjm375
//
//  Created by Benji Moon on 3/18/23.
//

import UIKit
import AVFoundation

var myAudioPlayerObj = AVAudioPlayer()

class HelpViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let mySound = Bundle.main.path(forResource: "sounds/gymaudio", ofType: "mp3")
        do {
            myAudioPlayerObj = try
            AVAudioPlayer(contentsOf: URL(fileURLWithPath: mySound!))
            myAudioPlayerObj.prepareToPlay()
            print("Sound file is loaded")
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func toggleSound(_ sender: Any) {
        print("sound is toggled")
        myAudioPlayerObj.play()
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
 
    

