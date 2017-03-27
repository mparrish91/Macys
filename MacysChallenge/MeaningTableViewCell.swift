//
//  MeaningTableViewCell.swift
//  MacysChallenge
//
//  Created by parry on 3/24/17.
//  Copyright © 2017 parry. All rights reserved.
//

import UIKit

struct constants {
    static let lowerLabelSpacing = 5
}

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
        
        //position meaning label along the horizontal center and off the leading edge
        meaningLabel.translatesAutoresizingMaskIntoConstraints = false
        meaningLabel.centerYAnchor.constraint(equalTo: margins.centerYAnchor).isActive = true
        meaningLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 3).isActive = true
        meaningLabel.font = UIFont(name: "Avenir-Book", size: 14)
        meaningLabel.textColor = UIColor.white
        
        //position freq label under the position label, with similar leading edge
        frequencyLabel.translatesAutoresizingMaskIntoConstraints = false
        frequencyLabel.leadingAnchor.constraint(equalTo: meaningLabel.leadingAnchor).isActive = true
        frequencyLabel.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor).isActive = true
        frequencyLabel.font = UIFont(name: "Avenir-Book", size: 8)
        frequencyLabel.textColor = UIColor.white
        
        //position since label under the position label, with  leading edge against freq label
        sinceLabel.translatesAutoresizingMaskIntoConstraints = false
        sinceLabel.leadingAnchor.constraint(equalTo: frequencyLabel.trailingAnchor, constant: CGFloat(constants.lowerLabelSpacing.hashValue)).isActive = true
        sinceLabel.topAnchor.constraint(equalTo: meaningLabel.bottomAnchor).isActive = true
        sinceLabel.font = UIFont(name: "Avenir-Book", size: 8)
        sinceLabel.textColor = UIColor.white
    }
    
}
