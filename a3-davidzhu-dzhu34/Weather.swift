//
//  Weather.swift
//  a3-davidzhu-dzhu34

import Foundation

class Weather:Codable{
    
    //property per attribute from api
    var current: myCurrent
    
    struct myCurrent:Codable{
        var temp_c: Double = 0.0
        var wind_kph: Double = 0.0
        var wind_dir: String = "Wind Direction Not Found"
    }
    
    //create a mapping between your properties and the actual name of the key in the API response
    enum CodingKeys: String, CodingKey{
        case current = "current"
    }
    
    func encode(to encoder: Encoder) throws {
        //print
    }

    required init(from decoder:Decoder) throws{
      //1. try to get api response
        let response = try decoder.container(keyedBy: CodingKeys.self)
        
        let curr1:myCurrent = myCurrent()
        
      //2. extract the relevant data
        self.current = try response.decodeIfPresent(myCurrent.self, forKey: CodingKeys.current) ?? curr1
        print(self.current.temp_c)
    }
}


