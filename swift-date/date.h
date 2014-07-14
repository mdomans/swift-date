//
//  Header.h
//  swift-date
//
//  Created by mdomans on 14/07/14.
//  Copyright (c) 2014 mdomans. All rights reserved.
//

struct Date {
    var calendar:NSCalendar
    var timezone:NSTimeZone
    var dateComponents:NSDateComponents
    var _date:NSDate
    
    var day:Int {
        get {}
    }
    var month:Int {
        get {}
    }
    var year:Int {
        get {}
    }
    var hour:Int {
        get {}
    }
    var second:Int {
        get {}
    }
    
    init(calendar:NSCalendar = NSCalendar.currentCalendar(), timezone:NSTimeZone = NSTimeZone(forSecondsFromGMT: 0), date:NSDate = NSDate()) 
    ///Creates a Date from given string, always remember that this method returns
    /// objects in NSTimeZone.localTimeZone()
    ///
    ///@param dateString:String
    /// String to parse
    ///
    ///@return
    /// Date
    init(dateString: String)
    
    func description() -> NSString
    
    static func parse(dateString:String) -> Date
}
