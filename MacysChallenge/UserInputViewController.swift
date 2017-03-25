//
//  UserInputViewController.swift
//  MacysChallenge
//
//  Created by parry on 3/22/17.
//  Copyright © 2017 parry. All rights reserved.
//

import UIKit

final class UserInputViewController: UIViewController {

    fileprivate var meaningsTableView: UITableView
    fileprivate var meanings: [Meaning]?
    fileprivate var refreshControl: UIRefreshControl

    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init?(_ coder: NSCoder? = nil) {
        self.meaningsTableView = UITableView()
        self.refreshControl = UIRefreshControl()
        
        if let coder = coder {
            super.init(coder: coder)
        }
        else {
            super.init(nibName: nil, bundle:nil)
        }
    }
    

    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(netHex: 0x1695A3)
        
        let cellIdentifier = "cell"
        meaningsTableView.register(MeaningTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        meaningsTableView.delegate = self
        meaningsTableView.dataSource = self
        meaningsTableView.addSubview(refreshControl)
//        refreshControl.addTarget(self, action: nil, for: UIControlEventValueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UserInputViewController.presentBadRequestAlert), name: NSNotification.Name(rawValue: "invalidInput"), object: nil)
        
        setConstraints()
    }
    
    
    override func loadView() {
        self.view = UIView()
        self.view.addSubview(meaningsTableView)
    }

    
    
    func presentBadRequestAlert() {
        let alertController = UIAlertController(title: nil, message: "oops looks like that acronym or initialism is not supported", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        }))
        
        present(alertController, animated: true, completion: nil)
    }


    //MARK: AutoLayout

    func setConstraints() {
        
        let margins = view.layoutMarginsGuide
        
        view.translatesAutoresizingMaskIntoConstraints = true
        
        meaningsTableView.translatesAutoresizingMaskIntoConstraints = false
        meaningsTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 100).isActive = true
        meaningsTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        meaningsTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        meaningsTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }
}



extension UserInputViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meanings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        
        //sure the downcast will succeed
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MeaningTableViewCell
        
//        guard let meanings = meanings else {
//            return
//        }
        
        
        if let meanings = meanings {
            let meaning = meanings[indexPath.row]
//            cell.frequencyLabel = meaning.frequency
//            cell.sinceLabel = meaning.since
            cell.meaningLabel.text = meaning.longForm

        }
        

        return cell
        
    }
}

extension UserInputViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text, !query.isEmpty {
            Meaning.retrieveMeanings(query, completionHandler: { (meanings, error) in
                self.meanings = meanings
                self.meaningsTableView.reloadData()
            })

        }
    }
}
    
