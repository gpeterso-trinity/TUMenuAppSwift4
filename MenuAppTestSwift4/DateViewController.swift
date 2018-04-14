//
//  DateViewController.swift
//  MenuAppTestSwift4
//
//  Created by gpeterso on 4/5/18.
//  Copyright © 2018 gpeterso. All rights reserved.
//

import UIKit

class DateViewController: UITableViewController {
    /* buttons */
    @IBOutlet weak var mondayButton: UITableViewCell!
    @IBOutlet weak var tuesdayButton: UITableViewCell!
    @IBOutlet weak var wednesdayButton: UITableViewCell!
    @IBOutlet weak var thursdayButton: UITableViewCell!
    @IBOutlet weak var fridayButton: UITableViewCell!
    @IBOutlet weak var saturdayButton: UITableViewCell!
    @IBOutlet weak var sundayButton: UITableViewCell!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  //checks for a selected cell in tableView and performs segue with that cell
        let sender = tableView.cellForRow(at: indexPath)
        self.performSegue(withIdentifier: (sender?.textLabel?.text)!, sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {                       //sets new view's navigation title to the title of the selected cell (the selected day)
        guard let sender = sender as? UITableViewCell else { return }
        segue.destination.navigationItem.title = sender.textLabel?.text
    }
}
