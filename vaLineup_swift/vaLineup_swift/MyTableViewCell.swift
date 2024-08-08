//
//  MyTableViewCell.swift
//  vaLineup_swift
//
//  Created by Juan Carlos Hernández Cárdenas.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    static func nib( ) -> UINib{
        return UINib(nibName: "MyTableViewCell", bundle: nil)
    }
    
    public func configure(with title: String, imageName: String){
        myLabel.text = title
        myImageView.image = UIImage(systemName: imageName)
    }
    
    @IBOutlet var myImageView: UIImageView!
    @IBOutlet var myLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
