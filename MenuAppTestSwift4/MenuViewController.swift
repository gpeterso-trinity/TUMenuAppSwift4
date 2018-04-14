//
//  MenuViewController.swift
//  MenuAppTestSwift4
//
//  Created by gpeterso on 4/5/18.
//  Copyright © 2018 gpeterso. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    var day = ""
    
    /* set up menu dictionaries */
    var menuMon = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String]()]
    var menuTue = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String]()]
    var menuWed = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String]()]
    var menuThu = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String]()]
    var menuFri = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String]()]
    var menuSat = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String](), "PIZZA" : [String]()]
    var menuSun = ["COMFORT" : [String](), "DESSERT" : [String](), "INTERNATIONAL GRILL" : [String](), "PIZZA" : [String]()]
    
    @IBOutlet weak var tableLoadingIcon: UIActivityIndicatorView!
    
    
    
    /* initial setup */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        day =  String(navigationItem.title!.prefix(3))                                                      //gets the selected day by checking the navigation title (set by previous view)
    }
    override func viewDidAppear(_ animated: Bool) {
        splitFile()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /* populate tableView */
    override func numberOfSections(in tableView: UITableView) -> Int {                                      //sets number of sections to create
        return getMenuForDay().count                                                                        //returns the number of keys in the current day's menu dictionary
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {          //sets number of rows to create in each section
        return getMenuForDay()[sectionToString(section)]!.count                                             //returns the number of items in each section of the current day's menu dictionary
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {   //sets the text in each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as UITableViewCell //pulls a cell off the table to modify
        cell.textLabel?.text = getMenuForDay()[sectionToString(indexPath.section)]![indexPath.row]              //sets the chosen cell's text to the corresponding entry in the current day's menu dictionary
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {    //sets the title of each section of the table
        return sectionToString(section)
    }
    
    
    
    /* conversions */
    func getMenuForDay() -> [String : [String]] {                                                           //returns the menu dictionary corresponding to the current day
        switch day {
        case "Mon" : return menuMon
        case "Tue" : return menuTue
        case "Wed" : return menuWed
        case "Thu" : return menuThu
        case "Fri" : return menuFri
        case "Sat" : return menuSat
        case "Sun" : return menuSun
        default : return menuMon
        }
    }
    func sectionToString(_ section:Int) -> String {                                                         //converts a section number into the section name
        switch section {
        case 0 : return "COMFORT"
        case 1 : return "INTERNATIONAL GRILL"
        case 2 : return "DESSERT"
        case 3 : return "PIZZA"
        default : return "PIZZA"
        }
    }
    
    
    
    /* separate file into meu dictionaries */
    func splitFile() {
        tableLoadingIcon.startAnimating()                                                                   //shows a loading icon while menu is loading
        let bundle = Bundle.main                                                                            //the main bundle object gives access to the resources inside app
        let path = bundle.path(forResource: "TU_Breakfast", ofType: "txt")                                  //sets the file location with the given name and type.
        
        let filemgr = FileManager.default
        if filemgr.fileExists(atPath: path!){
            do {
                let fullText = try String(contentsOfFile: path!, encoding: .utf8)                             //reads the contents of the file at path using utf8 encoding.
                let newLineChars = NSCharacterSet.newlines                                                    //gets newline chars (U+000A ~ U+000D, U+0085, U+2028, and U+2029)
                let readings = fullText.components(separatedBy: newLineChars).filter{!$0.isEmpty} as [String] //filters the text file by newline chars and filters out extra spaces. Places result into an array.
                for i in 1 ..< readings.count {
                    let menuInfo = readings[i].components(separatedBy: "\t")                                //puts content of the current line into array separated by tab characters
                    
                    if menuInfo[0] == day {                                                                 //skips over menu information pertaining to other days
                        switch menuInfo[0] {                                                                //adds the menu info for the specified day into corresponding dictionary
                        case "Mon" : menuMon["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        case "Tue" : menuTue["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        case "Wed" : menuWed["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        case "Thu" : menuThu["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        case "Fri" : menuFri["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        case "Sat" : menuSat["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        case "Sun" : menuSun["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        default : menuMon["\(menuInfo[1])"]!.append("\(menuInfo[2])")
                        }
                    }
                    
                    if menuInfo.count >= 1 {                                                                //update the table
                        self.tableView.reloadData()
                    }
                }
            } catch let error as NSError { //finds catch clauses, which contain patterns that match against defined error conditions. Swift methods can signal an error condition NSError. Prints that error
                print("Error:\(error)")
            }
        }
        tableLoadingIcon.stopAnimating()
    }
}
