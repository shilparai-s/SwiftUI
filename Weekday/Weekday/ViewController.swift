//
//  ViewController.swift
//  Weekday
//
//  Created by Shilpa Seetharam on 07/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let calendar = Calendar(identifier: .gregorian)
        let currentDateComponents = calendar.component(.month, from: Date())
        print(calendar.date(bySetting: .month, value: currentDateComponents - 1 , of: Date()))
    
        
//        let firstWeekOfMonthDate = calendar.date(bySetting: .weekOfMonth, value: 1, of: Date())
//        print(firstWeekOfMonthDate)
//
//        let weekDayComponents = calendar.dateComponents([.weekOfMonth], from: Date())
//        var dateComponents = DateComponents()
//        dateComponents.day = -(weekDayComponents.weekOfMonth! - calendar.firstWeekday - 1)
//
//        print(calendar.date(bySetting: .weekOfMonth, value: 1, of: Date()))
//
//        var beginningOfWeek = calendar.date(byAdding: dateComponents, to: Date())!
//        let components = calendar.dateComponents([.year,.month,.day], from: beginningOfWeek)
//        print(calendar.date(from: components))
//
//        if let week = todaysDateComponents.weekOfMonth {
//        }
        
        

    }


}

