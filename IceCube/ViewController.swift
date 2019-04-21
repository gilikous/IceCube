//
//  ViewController.swift
//  IceCube
//
//  Created by Bryan Richard on 14/02/2019.
//  Copyright © 2019 Bryan Richard. All rights reserved.
//

import UIKit
import WebKit
import CoreMotion

class ViewController: UIViewController {

    
    @IBOutlet weak var ValeurAcc: UILabel!
    var motion = CMMotionManager()
    @IBOutlet weak var Chrono: UILabel!
    var timer: Timer!
    var valeurSec = 0
    var valeurMin = 0
    var valeurMilSec = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        motion.startAccelerometerUpdates()
        motion.startGyroUpdates()
        motion.startMagnetometerUpdates()
        motion.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.updateChrono), userInfo: nil, repeats: true)
    }
   
   
   
    @IBAction func Button(_ sender: Any) {
     _ = startAccelerometers()
    }
    
   
    @IBAction func LEDONOFF(_ sender: UISwitch) {
        if ( sender.isOn == true)
    {
        let imageurl = URL(string: "http://10.10.10.10/LEDON")!
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: imageurl){( data, response, error)in}
        
        task.resume()
        
    }
    else
    {
        let imageurl2 = URL(string: "http://10.10.10.10/LEDOFF")!
        
        let config2 = URLSessionConfiguration.default
        let session2 = URLSession(configuration: config2)
        
        let task2 = session2.dataTask(with: imageurl2){( data, response, error)in}
        
        task2.resume()
        }
    }
    
    func startAccelerometers() -> Double {
        
        let data = motion.accelerometerData!
        let z = data.acceleration.y
        ValeurAcc.text = String(z)
        // Use the accelerometer data in your app.
        return z
        }
    
    @objc func updateChrono()
    {
        valeurMilSec = valeurMilSec + 1
        if valeurMilSec==100 {
            valeurMilSec=0
            valeurSec = valeurSec+1
        }
        if valeurSec==60 {
            valeurSec=0
            valeurMin = valeurMin + 1
        }
        Chrono.text = String("\(valeurMin):\(valeurSec):\(valeurMilSec)")
    }

    @IBAction func ChronStop(_ sender: Any) {
        timer.invalidate()
    }
    
    @IBAction func StartChrono(_ sender: Any) {
         timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.updateChrono), userInfo: nil, repeats: true)
    }
    
    @IBAction func ButGo(_ sender: Any) {
        ChronStop(self)
        valeurSec = 0
        valeurMilSec = 0
        valeurMin = 0
        
        while startAccelerometers() < 0.3 {
            
        }
        StartChrono(self)
    }
    
    @IBAction func EffacerChrono(_ sender: Any) {
        valeurMin = 0
        valeurSec = 0
        valeurMilSec = 0
        Chrono.text = "00:00:00"
    }
    
  
    @IBAction func myNameButtonSay(_ sender: UIButton) {
        performSegue(withIdentifier: "showMyName", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMyName"{
            let VCDesination = segue.destination as! SecondViewController
            VCDesination.myName = Chrono.text!
            
        }
    }
}

