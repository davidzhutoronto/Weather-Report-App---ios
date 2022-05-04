//
//  History.swift
//  a3-davidzhu-dzhu34


import Foundation

class History{
    let city:String
    let time:String
    let wind:String
    let windDirection:String
    let temperature:String
    
    init(city:String, time:String, wind:String, windDirection:String, temperature:String){
        self.city = city
        self.time = time
        self.wind = wind
        self.windDirection = windDirection
        self.temperature = temperature
    }
}
