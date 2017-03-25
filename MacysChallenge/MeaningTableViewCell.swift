//
//  MeaningTableViewCell.swift
//  MacysChallenge
//
//  Created by parry on 3/24/17.
//  Copyright © 2017 parry. All rights reserved.
//

import UIKit

class MeaningTableViewCell: UITableViewCell {
    
    var meaningLabel: UILabel
    var frequencyLabel: UILabel
    var sinceLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.meaningLabel = UILabel()
        self.frequencyLabel = UILabel()
        self.sinceLabel = UILabel()
        
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(meaningLabel)
        contentView.addSubview(frequencyLabel)
        contentView.addSubview(sinceLabel)
        self.contentView.backgroundColor = .black

    }
    
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setConstraints()
    }


    func setConstraints() {
        let margins = contentView.layoutMarginsGuide
        
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 3).isActive = true
        meaningLabel.font = UIFont(name: "Avenir-Book", size: 14)
        meaningLabel.textColor = UIColor.white
        
//        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
//        meaningLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
//        frequencyLabel.trailingAnchor.constraint(equalTo: sinceLabel.leadingAnchor, constant: 3).isActive = true
//        frequencyLabel.font = UIFont(name: "Avenir-Book", size: 14)
//        frequencyLabel.textColor = UIColor.white
//        
//        sinceLabel.translatesAutoresizingMaskIntoConstraints = false
//        meaningLabel.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
//        sinceLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: 3).isActive = true
//        sinceLabel.font = UIFont(name: "Avenir-Book", size: 14)
//        sinceLabel.textColor = UIColor.white
    }

}
