//
//  ViewController.swift
//  UITableViewSearchController
//
//  Created by amit sahu on 21/09/16.
//  Copyright © 2016 tpcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate{
    
    var items = [Item]()
    var itemName: String?
    var filteredItem = [Item]()
    
    
    let searchController = UISearchController(searchResultsController: nil)

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        // initializing item value
        items = [
            Item(category:"Samsung", name:"Canvas"),
            Item(category:"Samsung", name:"Galaxy Porwer"),
            Item(category:"Samsung", name:"Galaxy SFive"),
            Item(category:"Apple", name:"iPhone Seven"),
            Item(category:"Apple", name:"iPhone Six S"),
            Item(category:"Samsung", name:"Note Seven"),
            Item(category:"Sony", name:"Xperia Sseries"),
            Item(category:"Sony", name:"Xperia Zseries")
        ]
        
        searchController.searchBar.scopeButtonTitles = ["All", "Apple", "Samsung", "Sony"]
        searchController.searchBar.delegate = self
        
        // search controller
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationItem.title = "Search"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "subtitleCell")
        let item: Item
        if searchController.active &&  searchController.searchBar.text != "" {
            if filteredItem.count > 0 && indexPath.row <  filteredItem.count  {
                item = filteredItem[indexPath.row]
                cell.textLabel?.text = item.name
                cell.detailTextLabel?.text = item.category
            }
        }else {
            item = items[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = item.category
        }
        
    
        
        return cell
    }
    
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item: Item
        if searchController.active && searchController.searchBar.text != ""{
            item = filteredItem[indexPath.row]
        }else{
            item = items[indexPath.row]
        }
        
        self.itemName = item.name
        self.performSegueWithIdentifier("showDetail", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let vc = segue.destinationViewController as! DetailViewController
            vc.itemName = self.itemName!
        }
    }
    
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        
        filteredItem = items.filter({( item : Item) -> Bool in
            let categoryMatch = (scope == "All") || (item.category == scope)
            return categoryMatch && item.name.lowercaseString.containsString(searchText.lowercaseString)
        })
        print(scope)

        tableView.reloadData()
    }

}

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}


