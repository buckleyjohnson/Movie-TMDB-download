//
//  Utilities.swift
//  MovieBrowser
//
//  Created by buckley johnson on 1/22/22.
//  Copyright © 2022 Lowe's Home Improvement. All rights reserved.
//

import Foundation


extension String {
    func monthAsString() -> String {
//            let df = DateFormatter()
//            df.setLocalizedDateFormatFromTemplate("MMM DD, yyyy")
//            return df.string(from: self)
        
        //let dateString = self//.movies[indexPath.row].release_date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD"

        let date = dateFormatter.date(from: self)

        dateFormatter.dateFormat = "MMM DD, yyyy"
        let newDate = dateFormatter.string(from: date!)
        return newDate
    }
}


extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}
