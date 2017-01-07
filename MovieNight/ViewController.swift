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

class ViewController: UIViewController, GenreViewControllerDelegate {

    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var navBarButton: UIBarButtonItem!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var button1Clicked = false
    var button2Clicked = false
    var resultsButtonClicked = false
    
    var myGroup = DispatchGroup()
    var downloadClass = DownloadClass()
    var person1Answers: [Int]?
    var person2Answers: [Int]?
    var finalAnswers = [Int]()
    var objects: [Int]?
    var movieTitleArray = [String]()
    var movieImageArray: [UIImage]? = [UIImage]()
    var posterPath: String = ""
    var resultArray: [[String: AnyObject]] = []
    var movieArray: [[String: Any]]?
    var answerSet = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        assignBackground()
        resultsButtonDesign()
        navBarDesign()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        button1Clicked = false
        button2Clicked = false
    }
    
    func genreViewControllerResponse(data: [Int]) {
        person1Answers = data
        
        for i in person1Answers! {
            finalAnswers.append(i)
        }
        
        answerSet = Array(Set(finalAnswers))
    }
    
    @IBAction func button1(_ sender: UIButton) {
        button1Clicked = true
        
        if resultArray.isEmpty {
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
                        strongSelf.resultArray = data
                        strongSelf.performSegue(withIdentifier: "showDetail", sender: sender)
                    }
                default:
                    break
                }
            }
        } else {
            performSegue(withIdentifier: "showDetail", sender: sender)
        }
    }
    
    @IBAction func button2(_ sender: UIButton) {
        button2Clicked = true
        
        if resultArray.isEmpty {
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
                        strongSelf.resultArray = data
                        strongSelf.performSegue(withIdentifier: "showDetail", sender: sender)
                    }
                default: break
                }
            }
        } else {
            performSegue(withIdentifier: "showDetail", sender: sender)
        }
    }
    
    @IBAction func resultsButton(_ sender: UIButton) {
        print("Movie data starting to download")
        
        print("Her der der IDs:", answerSet)
        
            downloadClass.downloadData(downloadCase: .movie, id: answerSet) { [weak self] result in
                guard let strongSelf = self else { return }
                
                switch result {
                case .failureWithError(let error):
                    print(error.localizedDescription)
                case .failureWithString(let string):
                    print(string)
                case .success(let result):
                    print("Movie data downloaded successfully")
                    if let data = result["results"] as? [[String: Any]] {
                        print("Her der data:", data)
                        strongSelf.movieArray = data
                        for i in data {
                            print("hodor")
                            self?.myGroup.enter()
                            strongSelf.downloadClass.downloadImage(downloadCase: .movie, path: (i["poster_path"] as! String)) { result in
                                switch result {
                                case .failureWithError(let error):
                                    print(error.localizedDescription)
                                case .failureWithString(let string):
                                    print(string)
                                case .imageSucces(let result):
                                    print("hallelujah")
                                    strongSelf.movieImageArray?.append(result)
                                default: break
                                }
                                self?.myGroup.leave()
                            }
                        }
                        self?.myGroup.notify(queue: DispatchQueue.main, execute: {
                            do {
                                if (self?.movieArray?.isEmpty)! {
                                    throw Errors.noMovies
                                } else {
                                    strongSelf.performSegue(withIdentifier: "showMovie", sender: sender)
                                }
                            } catch {
                                let alertController = UIAlertController(title: "No movies available", message: "No movies fit these genres", preferredStyle: .alert)
                                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alertController.addAction(action)
                                
                                self?.present(alertController, animated: true, completion: nil)
                            }
                        })
                    }
                default: break
            }
        }
    }

    @IBAction func navBarButton(_ sender: Any) {
        // TODO: Logic that empties chosen arrays of IDs
        movieArray = nil
        movieImageArray = nil
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            do {
                
                if Reachability.isInternetAvailable() == true {
                    let controller = segue.destination as! GenreViewController
                    
                    
                    controller.delegate = self
                    if sender as? UIButton == button1 {
                        // do something
                        controller.title = "Select genres"
                        controller.objects = nil
                        controller.objects = resultArray
                    } else if sender as? UIButton == button2 {
                        controller.title = "Select genres"
                        controller.objects = nil
                        controller.objects = resultArray
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
            
            do {
                
                if Reachability.isInternetAvailable() == true {
                    let controller = segue.destination as! MovieViewController
                    
                    if sender as? UIButton == resultsButton {
                        print("HomeImageArray: ", movieImageArray as Any)
                        controller.title = "Movies"
                        controller.objects = nil
                        controller.objects = movieArray
                        controller.movieImageArray = movieImageArray
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
