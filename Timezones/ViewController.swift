//
//  ViewController.swift
//
//  Created by Marco Pappalardo on 29/10/15.
//

import UIKit

class ViewController: UIViewController {


  @IBOutlet weak var timeLabel1: UILabel!
  @IBOutlet weak var timeLabel2: UILabel!


  @IBOutlet weak var timelabel4: UILabel!
  @IBOutlet weak var timelabel3: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.



    let offsetMoscow = 180 * 60
    let offsetNiceNODST = 60 * 60
    let offsetNiceDST = 120 * 60


    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .MediumStyle


    // 03/28/2015 @ 11:10pm (UTC)
    let timestamp1:Double = 1427584200
    let date1 = NSDate(timeIntervalSince1970: timestamp1)

    // 03/29/2015 @ 1:10am (UTC)
    let timestamp2:Double = 1427591400
    let date2 = NSDate(timeIntervalSince1970: timestamp2)

    print((timestamp2-timestamp1)/60/60)

    formatter.timeZone = NSTimeZone(forSecondsFromGMT: offsetMoscow)
    self.timelabel3.text = formatter.stringFromDate(date1)
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: offsetNiceNODST)
    self.timeLabel1.text = formatter.stringFromDate(date1)

    formatter.timeZone = NSTimeZone(forSecondsFromGMT: offsetMoscow)
    self.timelabel4.text = formatter.stringFromDate(date2)
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: offsetNiceDST)
    self.timeLabel2.text = formatter.stringFromDate(date2)



  }


  @IBAction func addCalendar1(sender: UIButton) {
  }
  @IBAction func addCalendar2(sender: UIButton) {
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

