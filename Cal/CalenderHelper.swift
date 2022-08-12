//
//  CalenderHelper.swift
//  Cal
//
//  Created by Nathaniel Whittington on 4/28/22.
//

import Foundation

class CalenderHelper {
    
    let calenderDate = Calendar.current
    
    func plusMonth(date:Date)->Date{
        
        return calenderDate.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(date:Date)->Date{
        return calenderDate.date(byAdding: .month, value: -1, to: date)!
        
    }
    
    func monthString(date:Date)->String{
        
        let dateF = DateFormatter()
        dateF.dateFormat = "LLLL"
        return dateF.string(from: date)
    }
    
    func yearString(date:Date)->String{
        let dateF = DateFormatter()
        dateF.dateFormat = "YYYY"
       return  dateF.string(from: date)
    }
    
    func daysInMonth(date:Date)->Int{
        let days = calenderDate.range(of: .day, in: .month, for: date)!
        return days.count
    }
    
    func dayOfMonth(date:Date)->Int{
        let componets = calenderDate.dateComponents([.day], from: date)
        return componets.day ?? 0
    }
    
    func firstOfMonth(date:Date)-> Date{
        let componets = calenderDate.dateComponents([.year, . month], from: date)
        return componets.calendar?.date(from: componets) ?? date
    }
    
    func weekDay(date:Date)-> Int{
        let componets = calenderDate.dateComponents([.weekday], from: date)
        return componets.weekday! - 1
    }
}
