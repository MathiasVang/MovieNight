//
//  MovieViewController.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 06/12/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var downloadClass = DownloadClass()
    var objects: [[String: Any]]?
    var unwrapObjects = [[String: Any]]()
    var countOfObjects = 1
    var movieImageArray: [UIImage]? = [UIImage]()
    var cachedImages = [String: UIImage]()
    var delegate: GenreViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupView()
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.delegate = self
        navBarDesign()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.reloadData()
    }
    
    func setupView() {
        
        if let obj = objects {
            unwrapObjects = obj
        }
        
        countOfObjects = unwrapObjects.count
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        cell.cellLabel.text = unwrapObjects[indexPath.row]["title"] as? String
        
        cell.cellImage.image = movieImageArray![indexPath.row]
        
        return cell
    }
    
    func navBarDesign() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 189/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MovieViewController.back(sender:)))
        newBackButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func back(sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}

