//
//  LongBreakViewController.swift
//  Procti
//LongBreakViewController
//  Created by Franky Chainoor Johari on 14/04/20.
//  Copyright © 2020 Franky Chainoor Johari. All rights reserved.
//

import UIKit
import AVFoundation

class LongBreakViewController: UIViewController {

    
    var timelength = 2
    var minutes = 0
    var seconds = 0
    
    var timer = Timer()
    var audioplayer = AVAudioPlayer()
    
    
    
    @IBOutlet weak var Timertxt: UILabel!
    @IBOutlet weak var playbtn: UIButton!
    
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var resetbtn: UIButton!
    @IBOutlet weak var pausebtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        pausebtn.isEnabled = false
        resetbtn.isEnabled = false
        backbtn.isHidden = true
        //audio player set up
        do{
            let audiopath = Bundle.main.path(forResource: "Ping", ofType: ".mp3")
            try audioplayer = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audiopath!))
        }catch{
            //Error
        }
        


        // Do any additional setup after loading the view.
    }
    

    @IBAction func playbtnact(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerMethod), userInfo: nil, repeats: true)
        playbtn.isEnabled = false
        pausebtn.isEnabled = true
        resetbtn.isEnabled = false
        
    }
    
    @IBAction func pausebtnact(_ sender: Any) {
        timer.invalidate()
        Timertxt.text = String(format: "%02d:%02d", minutes,seconds)
        playbtn.isEnabled = true
        pausebtn.isEnabled = false
        resetbtn.isEnabled = true
    }
    
    @IBAction func resetbtnact(_ sender: Any) {
        timer.invalidate()
        timelength = 2
        Timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        resetbtn.isEnabled = false
        playbtn.isEnabled = true
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
             backbtn.isHidden = false

         }else{
             timelength -= 1
    Timertxt.text = String(format: "%02d:%02d", minutes,seconds)
         }
     }
    
    
    @IBAction func backfocusbtnact(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "ViewController") as? ViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    

}
