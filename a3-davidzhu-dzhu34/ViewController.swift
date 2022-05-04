//
//  ViewController.swift
//  a3-davidzhu-dzhu34

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    //const
    let geocoder = CLGeocoder()
    let apiKey:String = "f3ac58dfb0a748f4b11181410221803"
    
    //variables
    var locationManager:CLLocationManager!
    var latitude:Double? = 0.0
    var longitude:Double? = 0.0
    var city:String = ""
    var apiEndpoint:String = ""
    var time:String = ""
    var historyList:[History] = []
    var historyCounter:Int = 0
    
    //outlets
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var windDirLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.locationManager = CLLocationManager()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        
        self.locationManager.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "See History", style: .done  , target: self, action: #selector(historyBtnPressed(_:))
        )
    }

    
    @IBAction func historyBtnPressed(_ sender: Any) {
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "historyScreen") as? HistoryController else {
                    print("Cannot find next screen")
                    return
                }
        nextScreen.historyList = historyList
                // - navigate to the next screen
                self.navigationController?.pushViewController(nextScreen, animated: true)
    }
    
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let cityToSave:String = cityLbl.text!
        let temperatureToAdd:String = tempLbl.text!
        let windSpeedToAdd:String = windLbl.text!
        let windDirToAdd:String = windDirLbl.text!
        let timeToAdd:String = self.getTime()
        
        var historyToadd = History(city: cityToSave, time: timeToAdd, wind: windSpeedToAdd, windDirection: windDirToAdd, temperature: temperatureToAdd)
        
        if(temperatureToAdd == "" || cityToSave == "An error occured, try again later."){
            return
        }
        
        historyList.append(historyToadd)
        
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "historyScreen") as? HistoryController else {
                    print("Cannot find next screen")
                    return
                }
        print(historyList.count)
        nextScreen.historyList = historyList
        show(nextScreen,sender: self) //do i need to show next page ?
    }
    
    
    //obtain current lat and lng
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currPosition = locations.first{
            latitude = currPosition.coordinate.latitude
            longitude = currPosition.coordinate.longitude
            
            guard let latitude = latitude else {
                return
            }
            guard let longitude = longitude else {
                return
            }
            print("Device is located at \(latitude), \(longitude)")
            
            //call get address function
            self.getAddress(latitude: latitude, longitude: longitude)
           
        }
    }
    
    //convert lat and lng to city
    private func getAddress(latitude:Double, longitude:Double){
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        self.geocoder.reverseGeocodeLocation(location) { (resultsList, error) in
            print("Sent request to geocoding service, waiting for response")
            
            if(error != nil){
                print("Error occured during geocoding request")
                print(error)
                self.cityLbl.text = "An error occured, try again later."
                return
            }
            
            if(resultsList != nil){
                if(resultsList!.count == 0){
                    self.cityLbl.text = "No coordinates found for this address"
                }else{
                    print("Coordinate found")
                    let placemark:CLPlacemark = resultsList!.first!
                    
                    if(placemark.locality != nil){
                        self.city = placemark.locality!
                        self.cityLbl.text = "\(self.city)"
                        self.getWeather(city: self.city)
                    }else{
                        self.cityLbl.text = "Can Not Find City"
                        self.tempLbl.text = ""
                        self.windLbl.text = ""
                        self.windDirLbl.text = ""
                        return
                    }
                    
                }
            }
        }
    }
    
    func getTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        
        var minuteToDisplay = "\(minute)"
        if (minute < 10){
            minuteToDisplay = "0\(minute)"
        }
        
        var hourToDisplay = "\(hour)"
        if (hour < 10){
            hourToDisplay = "0\(hour)"
        }
    
        if(hour < 12){
            return "\(hourToDisplay):\(minuteToDisplay)AM"
        } else {
            return "\(hourToDisplay):\(minuteToDisplay)PM"
        }
    }
    
    //get current weather
    private func getWeather(city:String){
        //removing white space within a city name i.e "San Francisco" -> "San%20Francisco"
        self.city = city.replacingOccurrences(of: " ", with: "%20")
        apiEndpoint = "http://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(self.city)&aqi=no"
        guard let url = URL(string:apiEndpoint) else{
            print("Could not convert the string to an URL object")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error{
                print("Error occured while fetching data from api")
                print(err)
                return
            }
            
            if let jsonData = data{
                do{
                    let decoder = JSONDecoder()
                    let decodedItem:Weather = try decoder.decode(Weather.self, from:jsonData)
                                        
                    DispatchQueue.main.async{
                    self.tempLbl.text = String(decodedItem.current.temp_c)
                    self.windLbl.text = String(Int(decodedItem.current.wind_kph))
                    self.windDirLbl.text = decodedItem.current.wind_dir
                    }
                }catch let error{
                    print("An error occured during JSON decoding")
                    print(error)
                }
            }
        }.resume()
    }
}

