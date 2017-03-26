//
//  SearchViewController.swift
//  MacysChallenge
//
//  Created by parry on 3/22/17.
//  Copyright © 2017 parry. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    fileprivate var meaningsTableView: UITableView
    fileprivate var meanings: [Meaning]?
    fileprivate let searchController = UISearchController(searchResultsController: nil)

    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(aDecoder)
    }
    
    init?(_ coder: NSCoder? = nil) {
        self.meaningsTableView = UITableView()
        
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
        
        let cellIdentifier = "cell"
        meaningsTableView.register(MeaningTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        meaningsTableView.delegate = self
        meaningsTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        meaningsTableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.setBackgroundImage(#imageLiteral(resourceName: "image"), for: .any, barMetrics: .default)
        searchController.searchBar.scopeBarBackgroundImage = #imageLiteral(resourceName: "image")
        searchController.searchBar.tintColor = .white
        
        let attributes = [
            NSForegroundColorAttributeName : UIColor.white,
            NSFontAttributeName : UIFont(name: "Avenir-Book", size: 14)
        ]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)


        
        meaningsTableView.backgroundColor = UIColor.black
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchViewController.presentBadRequestAlert), name: NSNotification.Name(rawValue: "invalidInput"), object: nil)
        
        setConstraints()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        
        meaningsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        meaningsTableView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        meaningsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        meaningsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        meaningsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}



extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meanings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        
        //sure the downcast will succeed
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MeaningTableViewCell
        
        if let meanings = meanings {
            let meaning = meanings[indexPath.row]
//            cell.frequencyLabel = meaning.frequency
//            cell.sinceLabel = meaning.since
            cell.meaningLabel.text = meaning.longForm

        }
        
        return cell
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let query = searchController.searchBar.text, !query.isEmpty {
            Meaning.retrieveMeanings(query, completionHandler: { (meanings, error) in
                
                if error == nil {
                    self.meanings = meanings
                    self.meaningsTableView.reloadData()
                } else {
                    self.meanings = nil
                    self.meaningsTableView.reloadData()
                    
                }
                
                
            })

        }
    }
}

extension SearchViewController:UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.showsCancelButton = false
        // You could also change the position, frame etc of the searchBar
    }
}
    
