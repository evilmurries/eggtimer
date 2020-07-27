//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    let alarm = "alarm_sound"
    var totalTime: Int = 0
    var secondsPassed: Int = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var progressbar: UIProgressView!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        // Reset timer variables for button press
        progressbar.progress = 0.0
        secondsPassed = 0
        timer.invalidate()
        guard let hardness = sender.currentTitle else { return }
        timerLabel.text = "Cooking eggs..."
        
        
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)

    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            print("\(secondsPassed) seconds passed")
            secondsPassed += 1
            progressbar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            timerLabel.text = "Done!"
            guard let url: URL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
            
            player = try! AVAudioPlayer(contentsOf: url)
            
            player.play()

        }
    }
}
