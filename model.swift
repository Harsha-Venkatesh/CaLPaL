//
//  model.swift
//  CalPal
//
//  Created by Harsha Venkatesh on 04/06/23.
//

import Foundation

struct Today:Identifiable {
    let id :String
    let Item:String
    let Cal:String
    
}
struct Weightlogger: Identifiable{
    let id :String
    let date:String
    let weight:String
}
struct Weekdata: Identifiable{
    let id :String
    let Day:String
    let Totalcal:Int
}
