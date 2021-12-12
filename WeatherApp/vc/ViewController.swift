//
//  ViewController.swift
//  WeatherApp
//
//  Created by Fazlik Ziyaev on 11/09/21.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var countryLb: UILabel!
    @IBOutlet weak var tempLb: UILabel!
    @IBOutlet weak var countryTf: UITextField!
    @IBOutlet weak var maxTempLb: UILabel!
    @IBOutlet weak var minTempLb: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    
    let apiKey = "242847f9f1ebe60a82f970bbbe512e52"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryTf.delegate = self
        searchBtn.layer.cornerRadius = 6
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        countryTf.endEditing(true)
    
        if countryTf.text == "" {
            countryLb.text = "Country name! "
            self.tempLb.text = "0°C"
            self.maxTempLb.text = "0°C"
            self.minTempLb.text = "0°C"
            return
        }
        
        getWeather()
        
        
    }
    
    func getWeather() {
        
        let urlExample = "https://api.openweathermap.org/data/2.5/weather?appid=242847f9f1ebe60a82f970bbbe512e52&units=metric&q=\(countryTf.text!.trimmingCharacters(in: .whitespaces))"
        
        self.countryTf.text = ""
        
        print(urlExample)
        
        // Creating URL
        let url = URL(string: urlExample)
        
        // Creating session
        let session = URLSession(configuration: .default)
        
        // Creating a task for session
        if url != nil {
            let task = session.dataTask(with: url!) { data, response, error in
                if error != nil {
                    print(error!)
                }
                self.workingWithData(data: data)
            }
            
            task.resume()
        }
    }
    
    func workingWithData(data: Data?){
        
        if let safeData = data {
            do {
                let decoder = JSONDecoder()
                let decodetData = try decoder.decode(WeatherModelFromAPI.self, from: safeData)
                
                DispatchQueue.main.async {
                    self.countryLb.text = decodetData.name
                    self.tempLb.text = "\(Int(decodetData.main.temp))°C"
                    self.maxTempLb.text = "Min \(Int(decodetData.main.temp_max))°C"
                    self.minTempLb.text = "Min \(Int(decodetData.main.temp_min))°C"
                }
                
            }catch {
                DispatchQueue.main.async {
                    self.countryLb.text = "Wrong country!"
                    self.tempLb.text = "0°C"
                    self.maxTempLb.text = "0°C"
                    self.minTempLb.text = "0°C"
                }
            }
        }
    }
}

