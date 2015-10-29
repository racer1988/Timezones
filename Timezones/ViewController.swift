//
//  ViewController.swift
//
//  Created by Marco Pappalardo on 29/10/15.
//

import UIKit
import EventKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var timeLabel1: UILabel!
  @IBOutlet weak var timeLabel2: UILabel!
  @IBOutlet weak var timelabel4: UILabel!
  @IBOutlet weak var timelabel3: UILabel!
  
  let eventStore = EKEventStore()
  
  
  override func viewWillAppear(animated: Bool) {
    checkCalendarAuthorizationStatus()
  }
  
  func checkCalendarAuthorizationStatus() -> Bool {
    let status = EKEventStore.authorizationStatusForEntityType(.Event)
    
    switch (status) {
    case EKAuthorizationStatus.Authorized:
      print("authorized")
      return true
      // Things are in line with being able to show the calendars in the table view
    case EKAuthorizationStatus.Restricted, EKAuthorizationStatus.Denied, EKAuthorizationStatus.NotDetermined:
      // We need to help them give us permission
      requestAccessToCalendar()
      return false
    }
  }
  
  func requestAccessToCalendar() {
    eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
      accessGranted, error in
      
      if accessGranted == true {
        print("access")
      } else {
        print("no access")
      }
    })
  }
  
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
    if checkCalendarAuthorizationStatus() {
      let event = EKEvent(eventStore: eventStore)
      
      event.title = "Flight 1 NCE to LON"
      event.notes = "Sun, 01 Nov 2015 09:00:00 GMT TO Sun, 01 Nov 2015 11:00:00 GMT ----- In NCE 10:00:00 AM to 12:00:00 PM"

      event.startDate = NSDate(timeIntervalSince1970: 1446368400)
      event.endDate = NSDate(timeIntervalSince1970: 1446375600)
      event.calendar = eventStore.defaultCalendarForNewEvents
      do {
        try eventStore.saveEvent(event, span: .ThisEvent)
      }
      catch {
        print("Hell Broke loose")
      }
    }
  }
  @IBAction func addCalendar2(sender: UIButton) {
    if checkCalendarAuthorizationStatus() {
      let event = EKEvent(eventStore: eventStore)
      
      
      event.title = "DST Flight 1 MOSCOW to NCE"
      event.notes = "Flight leaves Moscow at 23.10 GMT time (02.10 Moscow - 00.10 NCE) and arrives at 01.40 GMT time (04.40 Moscow - 3.40 NCE DST!)"
      event.startDate = NSDate(timeIntervalSince1970: 1427584200)
        event.endDate = NSDate(timeIntervalSince1970: 1427593200)
        event.calendar = eventStore.defaultCalendarForNewEvents
      do {
        try eventStore.saveEvent(event, span: .ThisEvent)
      }
      catch {
        print("Hell Broke loose")
      }
      
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

