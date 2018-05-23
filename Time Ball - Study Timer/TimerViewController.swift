//
//  TimerViewController.swift
//  Time Ball - Study Timer
//
//  Created by Anthony Schwartz on 5/22/18.
//  Copyright © 2018 Anthony Schwartz. All rights reserved.
//


// Errors: When pressing pause and start, it doesn't pause anymore and counts down twice as fast

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var pauseButtonTapped: UIButton!
    @IBOutlet weak var startButtonTapped: UIButton!
    
    
    var seconds = 60
    var timer = Timer()
    
    var isTimerRunning = false
    var resumeTapped = false
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(TimerViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
        pauseButtonTapped.isEnabled = true
        
    }
    
    @objc func updateTimer() {
        if seconds < 1 {
            timer.invalidate()
        } else {
            seconds -= 1
            countDown.text = timeString(time: TimeInterval(seconds))
            countDown.text = String(seconds)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButtonTapped.isEnabled = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func startButton(_ sender: UIButton) {
        if isTimerRunning == false {
            runTimer()
            self.startButtonTapped.isEnabled = false
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            isTimerRunning = false
            self.resumeTapped = true
            self.pauseButtonTapped.setTitle("Resume", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            isTimerRunning = true
            self.pauseButtonTapped.setTitle("Pause", for: .normal)
        }
        
        // Need to implement when paused is pressed and is paused, the button needs to show resume instead, so the use knows that it can be pressed twice
        
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        timer.invalidate()
        seconds = 60
        countDown.text = timeString(time: TimeInterval(seconds))
        
        isTimerRunning = false
        pauseButtonTapped.isEnabled = false
        startButtonTapped.isEnabled = true
    }
    
    
}

