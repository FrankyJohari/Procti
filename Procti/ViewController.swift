//
//  ViewController.swift
//  Procti
//
//  Created by Franky Chainoor Johari on 13/04/20.
//  Copyright © 2020 Franky Chainoor Johari. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {


    var timelength = 2
    var minutes = 0
    var seconds = 0
    var count = 0
    
    var timer = Timer()
    var audioplayer = AVAudioPlayer()
    
    
    @IBOutlet weak var Timertxt: UILabel!
    @IBOutlet weak var pausebtn: UIButton!
    @IBOutlet weak var startbtn: UIButton!
    
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var resetbtn: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    
    @IBOutlet weak var longbreakbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        Timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        pausebtn.isEnabled = false
        resetbtn.isEnabled = false
        nextbtn.isHidden = true
        longbreakbtn.isHidden = true
        //audio player set up
        do{
            let audiopath = Bundle.main.path(forResource: "Ping", ofType: ".mp3")
            try audioplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audiopath!))
        }catch{
            //Error
        }
        counting(count1:count)

    }

    
    @IBAction func mulaibtn(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerMethod), userInfo: nil, repeats: true)
        startbtn.isEnabled = false
        pausebtn.isEnabled = true
        resetbtn.isEnabled = false
  
 
    }
    @objc func timerMethod(){
        
        minutes = timelength/60
        seconds = timelength%60
        
        if(timelength==0){
            timer.invalidate()
            Timertxt.text = String(format: "%02d:%02d", minutes,seconds)
            audioplayer.play()
            pausebtn.isEnabled = false
            resetbtn.isEnabled = true
            nextbtn.isHidden = false
            count += 1
            counting(count1: count)
            if count == 4 {
                nextbtn.isHidden = true
                longbreakbtn.isHidden = false
            }
        }else{
            timelength -= 1
   Timertxt.text = String(format: "%02d:%02d", minutes,seconds)
        }
    }
    

    @IBAction func pausebtn(_ sender: UIButton) {
        timer.invalidate()
         Timertxt.text = String(format: "%02d:%02d", minutes,seconds)
        startbtn.isEnabled = true
        pausebtn.isEnabled = false
        resetbtn.isEnabled = true
    }
    
    @IBAction func resetbtn(_ sender: UIButton) {
        timer.invalidate()
        timelength = 2
        Timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        resetbtn.isEnabled = false
        startbtn.isEnabled = true
    }
    
    @IBAction func nextbtnact(_ sender: Any) {
        
        timelength = 2
        Timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        startbtn.isEnabled = true
        pausebtn.isEnabled = false
        resetbtn.isEnabled = false
        nextbtn.isHidden = true
        
        let vc = storyboard?.instantiateViewController(identifier: "BreakViewController") as? BreakViewController
        navigationController?.pushViewController(vc!, animated: true)
        vc?.data = count
        vc?.delegate = self
        
    }
    
    
    @IBAction func longbreakbtnact(_ sender: Any) {
        
        timelength = 2
        Timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        startbtn.isEnabled = true
        pausebtn.isEnabled = false
        resetbtn.isEnabled = false
        nextbtn.isHidden = true
        count=0
        
        let vcbreak = storyboard?.instantiateViewController(identifier: "LongBreakViewController") as? LongBreakViewController
        navigationController?.pushViewController(vcbreak!, animated: true)
        
    }
    
    
    //create alert func
    func createAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        //Create Button
        alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Next", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        //display the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func counting(count1: Int){
        switch count1 {
        case 1:
            star1.image = UIImage(systemName: "star.fill")
        case 2:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
        case 3:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
        case 4:
            star1.image = UIImage(systemName: "star.fill")
            star2.image = UIImage(systemName: "star.fill")
            star3.image = UIImage(systemName: "star.fill")
            star4.image = UIImage(systemName: "star.fill")
        default: break
        }
    }


    
}
extension ViewController: passdatatoVC {
    func passdata(str: Int) {
        count = str
    }
    
    
}
