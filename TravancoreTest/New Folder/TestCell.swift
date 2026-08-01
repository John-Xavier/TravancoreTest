//
//  TestCell.swift
//  TravancoreTest
//
//  Created by John Xavier  on 01/08/2026.
//

import UIKit

class TestCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var readUnreadLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.clipsToBounds = true
            profileImage.contentMode = .scaleAspectFill
        print("constraints:", contentView.constraints.count)
           print("subviews:", contentView.subviews.count)
           print("profileImage:", profileImage as Any)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = profileImage.bounds.height
        profileImage.layer.cornerRadius = height/2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
