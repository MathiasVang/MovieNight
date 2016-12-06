//
//  ViewController.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 21/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController {

    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var navBarButton: UIBarButtonItem!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var button1Clicked = false
    var button2Clicked = false
    var resultsButtonClicked = false
    
    var downloadClass = DownloadClass()
    var downloadedGenre: [String: AnyObject] = [:]
    var objects: [AnyObject]?
    var unwrapObjects = [AnyObject]()
    var countOfObjects = 1
    var genreNameArray = [String]()
    var genreIDArray = [Int]()
    var movieTitleArray = [String]()
    var movieImageArray = [String]()
    var posterPath: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignBackground()
        resultsButtonDesign()
        navBarDesign()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadData() {
        
        
    }
    
    @IBAction func button1(_ sender: UIButton) {
        
        if genreNameArray.isEmpty {
            print("Genre data starting to download")
            
            downloadClass.downloadData(downloadCase: .genre) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .failureWithError(let error):
                    print(error.localizedDescription)
                case .failureWithString(let string):
                    print(string)
                case .success(let result):
                    print("Genre data downloaded successfully")
                    if let data = result["genres"] as? [[String: AnyObject]] {
                        print(data)
                        for d in data {
                            let id = d["id"]
                            let name = d["name"]
                            self?.genreNameArray.append(name as! String)
                            self?.genreIDArray.append(id as! Int)
                        }
                        strongSelf.performSegue(withIdentifier: "showDetail", sender: sender)
                    }
                }
            }
        } else {
            performSegue(withIdentifier: "showDetail", sender: sender)
        }
    }
    
    @IBAction func button2(_ sender: UIButton) {
        
        if genreNameArray.isEmpty {
            print("Genre data starting to download")
            
            downloadClass.downloadData(downloadCase: .genre) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .failureWithError(let error):
                    print(error.localizedDescription)
                case .failureWithString(let string):
                    print(string)
                case .success(let result):
                    print("Genre data downloaded successfully(2)")
                    if let data = result["genres"] as? [[String: AnyObject]] {
                        print(data)
                        for d in data {
                            let id = d["id"]
                            let name = d["name"]
                            self?.genreNameArray.append(name as! String)
                            self?.genreIDArray.append(id as! Int)
                        }
                        strongSelf.performSegue(withIdentifier: "showDetail", sender: sender)
                    }
                }
            }
        } else {
            performSegue(withIdentifier: "showDetail", sender: sender)
        }
    }
    
    @IBAction func resultsButton(_ sender: UIButton) {
        
        if movieTitleArray.isEmpty {
            print("Movie data starting to download")
        
            downloadClass.downloadData(downloadCase: .movie) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .failureWithError(let error):
                    print(error.localizedDescription)
                case .failureWithString(let string):
                    print(string)
                case .success(let result):
                    print("Movie data downloaded successfully")
                    if let data = result["results"] as? [[String: AnyObject]] {
                        print(data)
                        for d in data {
                            let title = d["title"]
                            let image = d["poster_path"]
                            self?.movieTitleArray.append(title as! String)
                            self?.movieImageArray.append(image as! String)
                        
                            print(self?.movieImageArray as Any)
                        }
                        strongSelf.performSegue(withIdentifier: "showMovie", sender: sender)
                    }
                }
            }
        } else {
            performSegue(withIdentifier: "showMovie", sender: sender)
        }
    }
    
    @IBAction func navBarButton(_ sender: Any) {
        // TODO: Logic that empties chosen arrays of IDs
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            do {
                
                if Reachability.isInternetAvailable() == true {
                    let controller = segue.destination as! GenreViewController
                    
                    if sender as? UIButton == button1 {
                        // do something
                        controller.title = "Select genres"
                        controller.objects = nil
                        controller.objects = genreNameArray as [AnyObject]?
                    } else if sender as? UIButton == button2 {
                        controller.title = "Select genres"
                        controller.objects = nil
                        controller.objects = genreNameArray as [AnyObject]?
                    } else if sender as? UIButton == resultsButton {
                        controller.title = "Results"
                    }
                } else {
                    throw Errors.offline
                }
            } catch Errors.offline {
                let alertController = UIAlertController(title: "No Internet Connection", message: "Please make sure you are connected via WiFi or cellular", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                self.present(alertController, animated: true, completion: nil)
            } catch let error {
                fatalError("\(error)")
            }
        } else if segue.identifier == "showMovie" {
            // Do something
        }
    }


    // MARK: - Helper Methods
    
    func assignBackground() {
        let background = UIImage(named: "background")
        
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    func resultsButtonDesign() {
        resultsButton.layer.cornerRadius = 5
        resultsButton.layer.borderWidth = 1
    }
    
    func navBarDesign() {
        self.title = "Movie Night"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 189/255.0, green: 89/255.0, blue: 90/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        navBarButton.tintColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 0.65)
        navBarButton.title = "Clear"
    }
}
