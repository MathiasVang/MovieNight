//
//  DetailViewController.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 21/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var objects: [[String: AnyObject]]?
    var unwrapObjects = [[String: AnyObject]]()
    var countOfObjects = 1
    var selectedArray = [Int]()
    var limitOfSelections = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        tableView.allowsMultipleSelection = true
        
        
        // Setup delegates
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.delegate = self
        navBarDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unwrapObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        
        cell.cellLabel.text = unwrapObjects[indexPath.row]["name"] as? String
        cell.cellImage.isHidden = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        
        if selectedArray.count <= limitOfSelections - 1 {
            selectedArray.append((unwrapObjects[indexPath.row]["id"] as? Int)!)
            cell.cellImage.isHidden = false
            cell.cellLabel.text = unwrapObjects[indexPath.row]["name"] as? String
            cell.contentView.backgroundColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = UIColor.white
            cell.cellLabel.text = unwrapObjects[indexPath.row]["name"] as? String
        }

        print(selectedArray.count)
        print(selectedArray)
        
        headerCounter()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        selectedArray = selectedArray.filter{$0 != unwrapObjects[indexPath.row]["id"] as? Int}
        print(selectedArray.count)
        cell.cellImage.isHidden = true
        cell.cellLabel.text = unwrapObjects[indexPath.row]["name"] as? String
        
        headerCounter()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let controller = viewController as? ViewController {
            controller.button1.isEnabled = true
            controller.button2.isEnabled = true
            controller.resultsButton.isEnabled = true
        }
    }
    
    // MARK: - Helper Methods
    
    func setupView() {
        
        if let obj = objects {
            unwrapObjects = obj
        }
        countOfObjects = unwrapObjects.count
    }
    
    func navBarDesign() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 189/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GenreViewController.done(sender:)))
        newBackButton.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.65)
        self.navigationItem.rightBarButtonItem = newBackButton
        newBackButton.isEnabled = false
    }

    
    func done(sender: UIBarButtonItem) {
        
        let homeScreen = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        homeScreen.objects = self.selectedArray as [Int]?
        navigationController?.pushViewController(homeScreen, animated: true)
        print(homeScreen.objects?.count as Any)
        print(homeScreen.objects as Any)
    }
    
    func headerCounter() {
        switch selectedArray.count {
        case 0: self.title = "Select genres"
        case 1...limitOfSelections: self.title = "\(selectedArray.count) of 5 selected"
        default: break
        }
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GenreViewController.done(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = newBackButton
        
        if selectedArray.count < limitOfSelections {
            newBackButton.isEnabled = false
        } else {
            newBackButton.isEnabled = true
        }
    }
}

