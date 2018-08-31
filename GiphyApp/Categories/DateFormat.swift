//
//  DateFormat.swift
//  GiphyApp
//
//  Created by Nataliya Murauyova on 8/29/18.
//  Copyright © 2018 Nataliya Murauyova. All rights reserved.
//

import Foundation


extension String{
    static func convertDateFrom(date: String) -> String?{
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "\(dateFormats.oldFormat)"
        
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "\(dateFormats.newFormat)"
        
        if let getDate = dateFormatterGet.date(from: date){
            let dateForLabel = dateFormatterPrint.string(from: getDate)
            return dateForLabel
        }
        return nil
    }
}
