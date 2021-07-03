//
//  DateFormatter.swift
//  
//
//  Created by Paulo Fierro on 3/7/21.
//

import Foundation

extension DateFormatter {
    
    /// A formatter used to encode dates for API requests
    static var apiRequestFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    /// A formatter used to decode dates from API results
    static var apiResultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
}
