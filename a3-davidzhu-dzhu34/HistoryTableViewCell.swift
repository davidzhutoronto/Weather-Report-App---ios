//
//  HistoryTableViewCell.swift
//  a3-davidzhu-dzhu34


import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var cityDateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
