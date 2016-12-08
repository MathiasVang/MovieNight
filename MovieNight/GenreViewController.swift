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
    
    var objects: [AnyObject]?
    var movie: MovieType?
    var unwrapObjects = [AnyObject]()
    var countOfObjects = 1
    var countOfGenres = 0
    var descrArray = [String]()
    var selectedArray = [String]()
    var limitOfSelections = 5
    var typeArray = [MovieType]()
    var user1Choice = [MovieType]()
    var user2Choice = [MovieType]()
    var lastSelectedIndexPath: NSIndexPath?

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
        return descrArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        cell.cellLabel.text = descrArray[indexPath.row]
        
        
        
        cell.cellImage.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell
        
        if selectedArray.count <= limitOfSelections - 1 {
            selectedArray.append(descrArray[indexPath.row])
            cell.cellImage.isHidden = false
            cell.cellLabel.text = descrArray[indexPath.row]
            cell.contentView.backgroundColor = UIColor.white
        } else {
            cell.contentView.backgroundColor = UIColor.white
            cell.cellLabel.text = descrArray[indexPath.row]
        }

        print(selectedArray.count)
        
        /*var type = typeArray[indexPath.row]
        
        type.selected = !type.selected
        typeArray[(indexPath as NSIndexPath).row] = type
        
        if type.selected {
            if user1Choice.count < limitOfSelections {
                user1Choice.append(type)
            } else if user1Choice.count == limitOfSelections && user2Choice.count < limitOfSelections {
                user2Choice.append(type)
            }
            numberOfRowsSelected += 1
        } else {
            if user1Choice.count < limitOfSelections {
                for (index, typeSelected) in user1Choice.enumerated() {
                    if typeSelected.id == type.id {
                        user1Choice.remove(at: index)
                    }
                }
            } else if user1Choice.count == limitOfSelections && user2Choice.count < limitOfSelections {
                for (index, typeSelected) in user2Choice.enumerated() {
                    if typeSelected.id == type.id {
                        user2Choice.remove(at: index)
                    }
                }
            }
            numberOfRowsSelected -= 1
        }*/
        
        headerCounter()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath) as! GenreCell

        selectedArray = selectedArray.filter{$0 != descrArray[indexPath.row]}
        print(selectedArray.count)
        cell.cellImage.isHidden = true
        cell.cellLabel.text = descrArray[indexPath.row]
        print(cell.cellImage)
        
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
        
        for i in 0 ..< countOfObjects {
            descrArray.append(objects?[i] as! String)
            countOfGenres += 1
        }
        
        countOfObjects = unwrapObjects.count
    }
    
    func navBarDesign() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 189/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(GenreViewController.back(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
    }
    
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func headerCounter() {
        switch selectedArray.count {
        case 0: self.title = "Select genres"
        case 1...limitOfSelections: self.title = "\(selectedArray.count) of 5 selected"
        default: break
        }
    }
}

