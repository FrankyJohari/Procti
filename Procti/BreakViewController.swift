//
//  BreakViewController.swift
//  Procti
//
//  Created by Franky Chainoor Johari on 14/04/20.
//  Copyright © 2020 Franky Chainoor Johari. All rights reserved.
//

import UIKit
import AVFoundation

protocol passdatatoVC {
    func passdata(str:Int)
    
}

class BreakViewController: UIViewController {

    @IBOutlet weak var pausebtn: UIButton!
    
    @IBOutlet weak var timertxt: UILabel!
    @IBOutlet weak var startbtn: UIButton!
    
    @IBOutlet weak var resetbtn: UIButton!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var backbtn: UIButton!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    var data:Int = 0
    var delegate: passdatatoVC!
    
    var timelength = 2
    var minutes = 0
    var seconds = 0
    
    var timer = Timer()
    var audioplayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
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
        counting(count1:data-1)
    }
    
    
    @IBAction func mulaibtnact(_ sender: Any) {
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
             timertxt.text = String(format: "%02d:%02d", minutes,seconds)
             audioplayer.play()
             pausebtn.isEnabled = false
             resetbtn.isEnabled = true
             backbtn.isHidden = false
             counting(count1: data)
         }else{
             timelength -= 1
    timertxt.text = String(format: "%02d:%02d", minutes,seconds)
         }
     }
    

    @IBAction func pausebtnact(_ sender: Any) {
        timer.invalidate()
         timertxt.text = String(format: "%02d:%02d", minutes,seconds)
        startbtn.isEnabled = true
        pausebtn.isEnabled = false
        resetbtn.isEnabled = true
    }
    
    
    @IBAction func resetbtnact(_ sender: Any) {
        timer.invalidate()
        timelength = 2
        timertxt.text = String(format: "%02d:%02d", timelength/60,timelength%60)
        resetbtn.isEnabled = false
        startbtn.isEnabled = true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backbtnact(_ sender: Any) {
        delegate.passdata(str: data)
        navigationController?.popViewController(animated: true)
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
