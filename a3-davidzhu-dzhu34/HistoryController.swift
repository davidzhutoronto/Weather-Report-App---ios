//
//  HistoryController.swift
//  a3-davidzhu-dzhu34
//

import UIKit

class HistoryController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //variables
    var historyList:[History] = []
    
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var cityDateLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.delegate = self
        historyTableView.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    // Define the total number of rows you want to display in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyList.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "weatherHistory", for:indexPath) as! HistoryTableViewCell
        
        let  currHistory = historyList[indexPath.row]
       
        cell.cityDateLbl!.text = "\(currHistory.city) at \(currHistory.time)"
        cell.temperatureLbl.text = "\(currHistory.temperature) °C"
        cell.windLbl.text = "Wind: \(currHistory.wind)kph from \(currHistory.windDirection)"
        return cell
        
    }
}
