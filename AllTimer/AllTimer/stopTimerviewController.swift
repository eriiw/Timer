//
//  stopTimer.swift
//  AllTimer
//
//  Created by ERII WATANABE on 2016/03/09.
//  Copyright © 2016年 ERII WATANABE. All rights reserved.
//

import UIKit
import AVFoundation

class stopTimerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var laptimerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var lapButton: UIButton!
    @IBOutlet weak var timeTable: UITableView!
    
    
    
    
    var startTime: NSTimeInterval? = nil
    var timer: NSTimer?
    var startTime2: NSTimeInterval? = nil
    var timer2: NSTimer?
    var elapsedTime: Double = 0.0
    var elapsedTime2: Double = 0.0
    var soundTime: Double = 0.0
    var _player = [AVAudioPlayer]() //プレイヤー
    var isPlaying: Bool = false
    var count1 = 0
    var count2 = 0
    
    var totalTime: Double = 0
    var splitTime: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonEnabled(true, stop: false, reset: false, lap: false)
        
        //プレイヤーの生成
        
        _player.append(makeAudioPlayer("button01a.mp3")!)
        // Do any additional setup after loading the view, typically from a nib.
        
        timeTable.delegate = self
        timeTable.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // セルに表示するテキスト
    var texts:[String] = []
    
    
    // セルの行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }
    
    
    //セルの内容を変更
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        
        
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
    
    
    
    /////////////
    
    func setButtonEnabled(start:Bool, stop:Bool, reset:Bool, lap:Bool) {
        self.startButton.enabled = start
        self.stopButton.enabled = stop
        self.resetButton.enabled = reset
        self.lapButton.enabled = lap
    }
    
    func update() {
        if let t = self.startTime {
            var time: Double = NSDate.timeIntervalSinceReferenceDate() - t + self.elapsedTime
            splitTime = time
            time += totalTime
            let sec: Int = Int(time)
            let msec: Int = Int((time - Double(sec)) * 100.0)
            self.timerLabel.text = String(format: "%02d:%02d:%02d", sec/60, sec%60, msec)
            
            if time % 10 == 0 {
                _player[0].currentTime = 0
                _player[0].play()
            }
            
            //print("\(time)")
            
        }
    }
    
    func update2() {   //ラップタイム
        if let t2 = self.startTime2 {
            let time2: Double = NSDate.timeIntervalSinceReferenceDate() - t2 + self.elapsedTime2
            let sec2: Int = Int(time2)
            let msec2: Int = Int((time2 - Double(sec2)) * 100.0)
            self.laptimerLabel.text = String(format: "%02d:%02d:%02d", sec2/60, sec2%60, msec2)
        }
    }
    
    
    @IBAction func lapButton(sender: AnyObject) {
        self.texts.insert(laptimerLabel.text!, atIndex: 0)
        self.timeTable.reloadData()
        self.startTime2 = NSDate.timeIntervalSinceReferenceDate()
        // 2001/1/1 0:0:0
    }
    
    
    @IBAction func startButton(sender: AnyObject) {
        setButtonEnabled(false, stop: true, reset: false, lap:true)
        self.startTime = NSDate.timeIntervalSinceReferenceDate() // 2001/1/1 0:0:0
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        //ラップタイム
        self.startTime2 = NSDate.timeIntervalSinceReferenceDate() // 2001/1/1 0:0:0
        self.timer2 = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: Selector("update2"), userInfo: nil, repeats: true)    }
    
    
    @IBAction func stopButton(sender: AnyObject) {
        setButtonEnabled(true, stop: false, reset: true, lap: false)
        self.timer2?.invalidate()
        //self.timer2 = nil
        self.timer?.invalidate()
        
        
        
        let time = totalTime + splitTime
        totalTime = time
        
        print("\(totalTime)")
        
    }
    
    @IBAction func resetButton(sender: AnyObject) {
        setButtonEnabled(true, stop: false, reset: false, lap: false)
        self.elapsedTime = 0.0
        self.startTime = nil
        self.timerLabel.text = "00:00:00"
        
        //ラップタイム
        self.elapsedTime2 = 0.0
        self.startTime2 = nil
        self.laptimerLabel.text = "00:00:00"
        
        totalTime = 0
        splitTime = 0
    }
    
    //オーディオプレイヤーの生成
    func makeAudioPlayer(res:String) -> AVAudioPlayer? {
        //リソースURLの生成
        let path = NSBundle.mainBundle().pathForResource(res, ofType:  "")
        let url = NSURL.fileURLWithPath(path!)
        
        do {
            //オーディオプレイヤーの生成
            return try AVAudioPlayer(contentsOfURL: url)
        } catch _ {
            return nil
        }
    }
    
}
    
    
    
    
    
    
    

