extension NSDate {
    
    convenience init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateStringFormatter.locale = NSLocale.systemLocale()
        let d = dateStringFormatter.dateFromString(dateString)
        self.init(timeInterval:0, sinceDate:d!)
    }
    
    class func dateFromMetOfficeString(string:String) -> NSDate {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-ddZ"
        dateStringFormatter.locale = NSLocale.systemLocale()
        let d = dateStringFormatter.dateFromString(string)
        return NSDate(timeInterval:0, sinceDate:d!)
    }
    
    class func areDatesSameDay(dateOne:NSDate,dateTwo:NSDate) -> Bool {
        var calender = NSCalendar.currentCalendar()
        let flags: NSCalendarUnit = .CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear
        var compOne: NSDateComponents = calender.components(flags, fromDate: dateOne)
        var compTwo: NSDateComponents = calender.components(flags, fromDate: dateTwo);
        return (compOne.day == compTwo.day && compOne.month == compTwo.month && compOne.year == compTwo.year);
    }
    
    class func stringFromDate(date:NSDate) -> NSString {
        var date_formatter = NSDateFormatter()
        date_formatter.dateFormat = "dd/MM/yyyy"
        var date_string = date_formatter.stringFromDate(date)
        return date_string
    }
    
    class func stringTimeFromDate(date:NSDate) -> NSString {
        var date_formatter = NSDateFormatter()
        date_formatter.dateFormat = "HH:mm"
        var date_string = date_formatter.stringFromDate(date)
        return date_string
    }
    
}