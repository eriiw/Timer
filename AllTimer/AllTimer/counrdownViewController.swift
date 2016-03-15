//
//  counrdownViewController.swift
//  AllTimer
//
//  Created by ERII WATANABE on 2016/03/08.
//  Copyright © 2016年 ERII WATANABE. All rights reserved.
//

import UIKit
import AVFoundation

class countdownViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var selecttimeButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pickerView2: UIPickerView!
    
    @IBOutlet weak var itbLabel: UILabel!
    @IBOutlet weak var itbButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var setButton: UIButton!
    
    
    
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loopButton: UIButton!
    
    //タイマー作動中の付属ボタン↑
    
    
    var startTime: NSTimeInterval? = nil
    var timer: NSTimer?
    var elapsedTime: Double = 0.0
    var soundTime: Double = 0.0
    var _player = [AVAudioPlayer]() //プレイヤー
    var _player2 = [AVAudioPlayer]() //プレイヤー
    var isPlaying: Bool = false
    var count: Int = 0
    var count2: Int = 0
    var startCount = 0
    var startCount2 = 0
    var setCount = 0
    var isLoop = false
    var isLoop2 = false
    var isInterval = false
    var playPicker = false
    var isSet = false
    
    
    //通常のデータ
    var LIST01:NSArray = ["00時", "01時", "02時", "03時", "04時", "05時", "06時", "07時", "08時", "09時", "10時", "11時", "12時", "13時", "14時", "15時", "16時", "17時", "18時", "19時", "20時", "21時", "22時", "23時", "24時", "25時", "26時", "27時", "28時", "29時", "30時", "31時", "32時", "33時", "34時", "35時", "36時", "37時", "38時", "39時", "40時", "41時", "42時", "43時", "44時", "45時", "46時", "47時", "48時", "49時", "50時", "51時", "52時", "53時", "54時", "55時", "56時", "57時", "58時", "59時"]
    var LIST02:NSArray = ["00分", "01分", "02分", "03分", "04分", "05分", "06分", "07分", "08分", "09分", "10分", "11分", "12分", "13分", "14分", "15分", "16分", "17分", "18分", "19分", "20分", "21分", "22分", "23分", "24分", "25分", "26分", "27分", "28分", "29分", "30分", "31分", "32分", "33分", "34分", "35分", "36分", "37分", "38分", "39分", "40分", "41分", "42分", "43分", "44分", "45分", "46分", "47分", "48分", "49分", "50分", "51分", "52分", "53分", "54分", "55分", "56分", "57分", "58分", "59分"]
    var LIST03:NSArray = ["00秒", "01秒", "02秒", "03秒", "04秒", "05秒", "06秒", "07秒", "08秒", "09秒", "10秒", "11秒", "12秒", "13秒", "14秒", "15秒", "16秒", "17秒", "18秒", "19秒", "20秒", "21秒", "22秒", "23秒", "24秒", "25秒", "26秒", "27秒", "28秒", "29秒", "30秒", "31秒", "32秒", "33秒", "34秒", "35秒", "36秒", "37秒", "38秒", "39秒", "40秒", "41秒", "42秒", "43秒", "44秒", "45秒", "46秒", "47秒", "48秒", "49秒", "50秒", "51秒", "52秒", "53秒", "54秒", "55秒", "56秒", "57秒", "58秒", "59秒"]
    
    
    // インターバル表示データ定数　配列
    var ITEM01:NSArray = ["0分", "1分", "2分", "3分", "4分", "5分", "6分", "7分", "8分", "9分", "10分", "11分", "12分", "13分", "14分", "15分", "16分", "17分", "18分", "19分", "20分", "21分", "22分", "23分", "24分", "25分", "26分", "27分", "28分", "29分", "30分", "31分", "32分", "33分", "34分", "35分", "36分", "37分", "38分", "39分", "40分", "41分", "42分", "43分", "44分", "45分", "46分", "47分", "48分", "49分", "50分", "51分", "52分", "53分", "54分", "55分", "56分", "57分", "58分", "59分"]
    var ITEM02:NSArray = ["00秒", "01秒", "02秒", "03秒", "04秒", "05秒", "06秒", "07秒", "08秒", "09秒", "10秒", "11秒", "12秒", "13秒", "14秒", "15秒", "16秒", "17秒", "18秒", "19秒", "20秒", "21秒", "22秒", "23秒", "24秒", "25秒", "26秒", "27秒", "28秒", "29秒", "30秒", "31秒", "32秒", "33秒", "34秒", "35秒", "36秒", "37秒", "38秒", "39秒", "40秒", "41秒", "42秒", "43秒", "44秒", "45秒", "46秒", "47秒", "48秒", "49秒", "50秒", "51秒", "52秒", "53秒", "54秒", "55秒", "56秒", "57秒", "58秒", "59秒"]
    
    
    //固定文字
    private let labelText = ["時", "分"]
    // ラベルのテキスト
    private var labels :[UILabel] = []
    
    
    
    //MARK -Instance Methods
    // func updateLabel(){
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //ボタン表示非表示
        setButtonEnabled(false, close: false, selectTime: true, stop: false, reset: false, loop: false, itb: false, set: false)
        // Do any additional setup after loading the view, typically from a nib.
        
        //プレイヤーの生成
        _player.append(makeAudioPlayer("button01a.mp3")!)
        _player2.append(makeAudioPlayer("stopsound.mp3")!)
        
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    // 設定（コンポーネント数（列数））
    func numberOfComponentsInPickerView2(pickerView2: UIPickerView) -> Int {
        return 3
    }
    
    // 設定（行数）
    func pickerView2(pickerView2: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            if(component == 0){
                return LIST01.count;  // 1列目の選択肢の数
            }else if (component == 1){
                return LIST02.count;// 2列目の選択肢の数
            }else if (component == 2){
                return LIST03.count;// 3列目の選択肢の数
            }
            return 0;
            
    }
    
    // 設定（文字列データ表示）
    func pickerView2(pickerView2: UIPickerView,
        titleForRow row: Int,                // 行
        forComponent component: Int) -> String! {   // 列
            
            if(component == 0){
                return LIST01[row] as! String  // 1列目のrow番目に表示する値
            }else if (component == 1){
                return LIST02[row] as! String  // 2列目のrow番目に表示する値
            }else if (component == 2){
                return LIST03[row] as! String  // 1列目のrow番目に表示する値
            }
            return "";
            
    }
    
    
    
    
    // データ選択時
    func pickerView2(pickerView2: UIPickerView,
        didSelectRow row: Int,     // 行
        inComponent component: Int) {   // 列
            let tag = pickerView.tag
            if tag == 2 {
                self.pickerView2(pickerView2, didSelectRow: row, inComponent: component)
                return
            }
            
            
            // 選択行のインデックスを取得
            
            var row1:NSInteger = pickerView2 .selectedRowInComponent(0) // 1列目の行
            var row2:NSInteger = pickerView2 .selectedRowInComponent(1) // 2列目の行
            var row3:NSInteger = pickerView2 .selectedRowInComponent(2) // 2列目の
            
            
            
            //タイマー
            var hour: Int = 0
            var minute: Int = 0
            var second: Int = 0
            let LIST01String: String = LIST01[row1] as! String
            let list01 = LIST01String.stringByReplacingOccurrencesOfString("時", withString: "")
            if let hourInt: Int? = Int(list01){
                hour = hourInt!
            }
            let LIST02String: String = LIST02[row2] as! String
            let list02 = LIST02String.stringByReplacingOccurrencesOfString("分", withString: "")
            if let minuteInt: Int? = Int(list02){
                minute = minuteInt!
            }
            
            let LIST03String: String = LIST03[row3] as! String
            
            let list03 = LIST03String.stringByReplacingOccurrencesOfString("秒", withString: "")
            
            if let secondInt: Int? = Int(list03){
                second = secondInt!
            }
            //ミリ秒を計算
            
            
            let msecond = hour * 3600 + minute * 60 + second
            startCount = msecond
            count = msecond
            timerLabel.text = toCountString(count)
            
            let hourleft1 = LIST01[row1].stringByReplacingOccurrencesOfString("時", withString: "")
            
            let minutecenter1 = LIST02[row2].stringByReplacingOccurrencesOfString("分", withString: "")
            
            let secondright1 = LIST03[row3].stringByReplacingOccurrencesOfString("秒", withString: "")
            //ラベルの表示
            self.timerLabel.text = NSString(format:"%@:%@:%@", "\(hourleft1)","\(minutecenter1)","\(secondright1)") as String
            
            
    }
    
    
    
    
    
    ////////////////////////
    //////インターバル////////
    ///////////////////////
    
    // 設定（コンポーネント数（列数））
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        let tag = pickerView.tag
        if tag == 2 {
            return self.numberOfComponentsInPickerView2(pickerView)
        }
        return 2
    }
    
    // 設定（行数）
    func pickerView(pickerView: UIPickerView,
        numberOfRowsInComponent component: Int) -> Int {
            let tag = pickerView.tag
            if tag == 2 {
                return pickerView2(pickerView, numberOfRowsInComponent: component)
            }
            if(component == 0){
                return ITEM01.count;  // 1列目の選択肢の数
            }else{
                return ITEM02.count;  // 2列目の選択肢の数
            }
    }
    
    // 設定（文字列データ表示）
    func pickerView(pickerView: UIPickerView,
        titleForRow row: Int,                // 行
        forComponent component: Int) -> String! {   // 列
            let tag = pickerView.tag
            if tag == 2 {
                return pickerView2(pickerView, titleForRow: row, forComponent: component)
            }
            if(component == 0){
                return ITEM01[row] as! String  // 1列目のrow番目に表示する値
            }else{
                return ITEM02[row] as! String  // 2列目のrow番目に表示する値
            }
    }
    
    
    
    
    // データ選択時
    func pickerView(pickerView: UIPickerView,
        didSelectRow row: Int,     // 行
        inComponent component: Int) {// 列
            let tag = pickerView.tag
            if tag == 2 {
                self.pickerView2(pickerView, didSelectRow: row, inComponent: component)
                
                
                return
            }
            
            // 選択行のインデックスを取得
            var row01:NSInteger = pickerView .selectedRowInComponent(0) // 1列目の行
            var row02:NSInteger = pickerView .selectedRowInComponent(1) // 2列目の行
            
            
            
            
            //インターバルタイマー
            
            var minute: Int = 0
            var second: Int = 0
            let ITEM01String: String = ITEM01[row01] as! String
            
            let item01 = ITEM01String.stringByReplacingOccurrencesOfString("分", withString: "")
            if let minuteInt: Int? = Int(item01){
                minute = minuteInt!
            }
            
            let ITEM02String: String = ITEM02[row02] as! String
            
            let item02 = ITEM02String.stringByReplacingOccurrencesOfString("秒", withString: "")
            
            if let secondInt: Int? = Int(item02){
                second = secondInt!
            }
            //ミリ秒を計算
            
            
            let msecond = minute * 60 + second
            startCount2 = msecond
            count2 = msecond
            itbLabel.text = convertIntervalFlomSecond(count2)
            
            let minuteleft = ITEM01[row01].stringByReplacingOccurrencesOfString("分", withString: "")
            
            let secondright = ITEM02[row02].stringByReplacingOccurrencesOfString("秒", withString: "")            //ラベルの表示
            self.itbLabel.text = NSString(format:"%@:%@", "\(minuteleft)","\(secondright)") as String
            
            
    }
    
    //各種ページのボタンの設定
    func setButtonEnabled(start:Bool,close:Bool,selectTime:Bool,stop:Bool,reset:Bool,loop:Bool,itb:Bool,set:Bool){
        self.startButton.enabled = start
        self.closeButton.enabled = close
        self.selecttimeButton.enabled = selectTime
        self.stopButton.enabled = stop
        self.resetButton.enabled = reset
        self.loopButton.enabled = loop
        self.itbButton.enabled = itb
        self.setButton.enabled = set
    }
    
    func update(){
        
        //ボタンとラベルの制御
        
        if isSet {
            if count > 0 {
                
                isSet = true
            }
            
            
        }
        
        
        
        
        //インターバル処理
        if isInterval {
            
            
            count2 -= 1
            self.itbLabel.text = convertIntervalFlomSecond(count2)
            if count2 % 10 == 0 {
                _player[0].currentTime = 0
                _player[0].play()
                
                
            }
            
            if count2 == 0 {
                
                isInterval = false
                count2 = startCount2
                
                
            }
        } else {
            
            count -= 1
            self.timerLabel.text = toCountString(count)
            if count % 10 == 0 {
                _player[0].currentTime = 0
                _player[0].play()
                
            }
            
            if count == 0 {
                isInterval = true
                
                /* func resetIntervalCount(givenCount: Int) ->Bool{
                count2 = givenCount
                isInterval = resetIntervalCount(count2)
                return true
                }*/
                
            }
            
            
            
            
            
            
            ////////////
            if count % 60 == 0 {
                _player2[0].currentTime = 0
                _player2[0].play()
                
                
            }}
        
        /*/ 終了判定 3分が00:00になったら isEqualToString:文字の比較
        if self.timerLabel == 0 {
        self.timer?.invalidate()
        //timerを生成する.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        
        
        }
        if self.itbLabel == 0 {
        self.timer?.invalidate()
        
        //timerを生成する.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)
        
        
        }*/
        
        
        
        
        //ループ
        if count == 0 {
            
            //時間の繰り返しLooP
            if isLoop {
                
                count = startCount
                
                return
                
            }
            if count2 == 0 {
                
                //時間の繰り返しLooP
                if isLoop {
                    
                    count2 = startCount2
                    
                    
                    return
                    
                }}
            
            
            //各種時間設定
            setButtonEnabled(false, close: false, selectTime: false, stop: false, reset: true, loop: false, itb: false, set: false)
            
            
            
            self.timer?.invalidate()
            self.timer = nil
        }
        
        
    }
    //00:00表示の桁
    func toCountString(count: Int) ->String {
        //分を求める（１８０を６０で割ると3分）
        let hour = Int(count / 3600)
        let minute = Int(count % 3600 / 60)
        //余りをだす
        let second = count % 60
        return String(format:"%02d:%02d:%02d", hour, minute, second)
        
        
    }
    
    
    //00:00表示の桁
    func convertIntervalFlomSecond(count2: Int) ->String {
        //分を求める（１８０を６０で割ると3分）
        //let hour = Int(count2 / 3600)
        let minute = Int(count2 % 3600 / 60)
        //余りをだす
        let second = count2 % 60
        return String(format:"%02d:%02d", minute, second)
    }
    
    
    
    
    
    
    
    
    //時間選択を押した時
    
    @IBAction func tapedselectButton(sender: AnyObject) {
        pickerView2.hidden = false;
        
        setButtonEnabled(false, close: true, selectTime: false, stop: false, reset: false, loop: false, itb: false, set: false)
        self.timerLabel.text = "00:00:00"
        
    }
    //ピッカーを閉じる
    
    
    
    @IBAction func tapedcloseButton(sender: AnyObject) {
        setButtonEnabled(true, close: false, selectTime: false, stop: false, reset: false, loop: true, itb: true, set: false)
        pickerView2.hidden = true;
    }
    
    //インターバルボタンのアクション
    
    @IBAction func itbButton(sender: AnyObject) {
        self.itbLabel.text = "00:00"
        pickerView.hidden = false;
        itbLabel.hidden = false;        setButtonEnabled(false, close: false, selectTime: false, stop: false, reset: false, loop: false, itb: false, set: true)
        
    }
    //インターバル選択を閉じる
    
    @IBAction func setButton(sender: AnyObject) {
        setButtonEnabled(false, close: false, selectTime: true, stop: false, reset: false, loop: true, itb: true, set: false)
        pickerView.hidden = true;
    }
    
    
    
    //タイマー作動中のボタン
    
    
    @IBAction func loopButton(sender: AnyObject) {
        setButtonEnabled(false, close: false, selectTime: false, stop: true, reset: false, loop: false, itb: false, set: false)
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("update"),userInfo:nil,repeats: true)
        isLoop = true
        
        
    }
    
    
    
    
    
    
    @IBAction func startButton(sender: AnyObject) {
        setButtonEnabled(false, close: false, selectTime: false, stop: true, reset: false, loop: false, itb: false, set: false)
        self.startTime = NSDate.timeIntervalSinceReferenceDate()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1,target:self,selector:Selector("update"),userInfo:nil,repeats: true)    }
    
    
    
    
    @IBAction func stopButton(sender: AnyObject) {
        setButtonEnabled(true, close: false, selectTime: false, stop: false, reset: true, loop: false, itb: false, set: false)
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    
    
    @IBAction func resetButton(sender: AnyObject) {
        setButtonEnabled(false, close: false, selectTime: true, stop: false, reset: false, loop: false, itb: false, set: false)
        
        self.startTime = nil
        startCount = 0
        self.timerLabel.text = toCountString(startCount)
        count = startCount
        
        
        startCount2 = 0
        self.itbLabel.text = convertIntervalFlomSecond(startCount2)
        count2 = startCount2
        
    }
    
    
    
    
    // 書式指定に従って日付を文字列に変換します
    // パラメータ
    //  date : 日付データ(NSDate型)を指定します
    //  style : 書式を指定します
    //          yyyy 西暦,MM 月,dd 日,HH 時,mm 分,ss 秒
    //
    func format(date : NSDate, style : String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "ja_JP")
        dateFormatter.dateFormat = style
        return  dateFormatter.stringFromDate(date)
        
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




