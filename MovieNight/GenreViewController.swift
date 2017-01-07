//
//  DetailViewController.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 21/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit

protocol GenreViewControllerDelegate {
    func genreViewControllerResponse(data: [Int])
}

class GenreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var objects: [[String: AnyObject]]?
    var unwrapObjects = [[String: AnyObject]]()
    var countOfObjects = 1
    var selectedArray = [Int]()
    var limitOfSelections = 2
    var person1Array = [Int]()
    var delegate: GenreViewControllerDelegate?
    

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
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GenreCell
        
        if person1Array.count <= limitOfSelections - 1 {
            person1Array.append((unwrapObjects[indexPath.row]["id"] as? Int)!)
            print(person1Array)
            cell.cellImage.isHidden = false
        }
        
        headerCounter()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! GenreCell
        person1Array = person1Array.filter{$0 != unwrapObjects[indexPath.row]["id"] as? Int}
        print(person1Array)
        cell.cellImage.isHidden = true
        
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
        self.delegate?.genreViewControllerResponse(data: person1Array)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func headerCounter() {
        
        if person1Array.count == 0 {
            self.title = "Select genres"
        } else if person1Array.count > 0 {
            self.title = "\(person1Array.count) of 2 selected"
        }
        
        let newBackButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GenreViewController.done(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = newBackButton
        
        if person1Array.count < limitOfSelections {
            newBackButton.isEnabled = false
        } else {
            newBackButton.isEnabled = true
        }
    }
}

