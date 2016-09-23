//
//  DetailViewController.swift
//  UITableViewSearchController
//
//  Created by amit sahu on 21/09/16.
//  Copyright © 2016 tpcg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var itemName: String = ""

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = self.itemName
        self.navigationController?.navigationBar.topItem?.title = ""
        self.detailLabel.text = self.itemName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
