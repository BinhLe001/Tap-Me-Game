//
//  ViewController.swift
//  Tap Me
//
//  Created by Binh Le on 7/8/15.
//
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var buttonBeep = AVAudioPlayer()
    var secondBeep = AVAudioPlayer()
    var backgroundMusic = AVAudioPlayer()
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        //1
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        //2
        var error: NSError?
        
        //3
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4
        return audioPlayer!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_tile.png")!)
        scoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_score.png")!)
        timerLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_time.png")!)
        buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type:"wav")
        secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type:"wav")
        backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type:"mp3")
        setUpGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    var count = 0
    var seconds = 0
    var timer = NSTimer()
    
    @IBAction func buttonPressed(){
        count++
        scoreLabel.text = "Score \n\(count)"
        buttonBeep.play()
    }
    
    func setUpGame(){
        seconds = 10
        count = 0
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        timerLabel.text = "Time: \(seconds)"
        scoreLabel.text = "Score: \(count)"
        backgroundMusic.volume = 0.3
        backgroundMusic.play()
    }
    
    func subtractTime(){
        seconds--
        timerLabel.text = "Time: \(seconds)"
        secondBeep.play()
        
        if (seconds == 0){
            timer.invalidate()
            let alert = UIAlertController(title: "Time is up!",
                message: "You scored \(count) points",
                preferredStyle: UIAlertControllerStyle.Alert)
           
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.setUpGame()
            }))
            
            presentViewController(alert, animated: true, completion:nil)
        }
    }
}

