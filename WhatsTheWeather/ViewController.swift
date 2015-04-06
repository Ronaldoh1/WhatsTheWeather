//
//  ViewController.swift
//  WhatsTheWeather
//
//  Created by Ronald Hernandez on 4/5/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userCityTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!

    func showError() {
        self.resultLabel.text = "Was not able to find weather for \(self.userCityTextField.text)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func findWeather(sender: AnyObject) {

        var url = NSURL(string: "http://www.weather-forecast.com/locations/london/forecasts/latest")
        var weather = ""

        //check it the url is nill
        if url != nil {


            var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in

                var urlError = false
                if error == nil {

                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    // println(urlContent);


                    //create an array that allows you to add
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")

                    if urlContentArray.count > 0{

                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        weather = weatherArray[0] as String



                    }
                    
                    
                    
                    
                    //println(urlContentArray)
                    
                }else {
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if urlError == true{
                        self.showError()
                    }else {
                        weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º", options: nil, range: nil)
                        
                        self.resultLabel.text = weather
                    }
                })
                
            })
            task.resume()
            
        }else {
            
            self.showError()
            
            
        }
    }
    
}

