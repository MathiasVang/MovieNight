//
//  ViewController.swift
//  MovieNight
//
//  Created by Mathias Vang Rasmussen on 21/11/2016.
//  Copyright © 2016 ReCapted. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var navBarButton: UIBarButtonItem!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    var button1Clicked = false
    var button2Clicked = false
    var resultsButtonClicked = false
    
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
    
    @IBAction func button1(_ sender: UIButton) {
        
    }
    
    @IBAction func button2(_ sender: UIButton) {
    }
    
    @IBAction func resultsButton(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            do {
                
                if Reachability.isInternetAvailable() == true {
                    let controller = segue.destination as! DetailViewController
                    
                    if sender as? UIButton == button1 {
                        // do something
                        controller.title = "Select genres"
                    } else if sender as? UIButton == button2 {
                        controller.title = "Select genres"
                    } else if sender as? UIButton == resultsButton {
                        controller.title = "Results"
                    }
                }
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

