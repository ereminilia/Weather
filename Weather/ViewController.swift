//
//  ViewController.swift
//  Weather
//
//  Created by Vitaliy Podolskiy on 09.11.2019.
//  Copyright © 2019 Vitaliy Podolskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var model: Model? {
        didSet {
            guard let model = model else { return }
            cityLabel.text = "Добавить город (home work)"
            latitudeLabel.text = "\(model.coordinate.latitude)"
            longitudeLabel.text = "\(model.coordinate.longitude)"
            if let weather = model.weather.first {
                mainLabel.text = weather.main
                descriptionLabel.text = weather.descriptionString
            }
        }
    }
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var button: UIButton! {
        didSet {
            button.setTitle(NSLocalizedString("button.title", comment: ""), for: .normal)
        }
    }
    
    @IBAction private func buttonWasTapped() {
        Net().requestWeather { model in
            self.model = model
        }
//        Net().requestWeather {
//            self.model = $0
//        }
    }
    
}

