//
//  TopCityWeatherCell.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class TopCityWeatherCell: UITableViewCell {
    
    static let identifier = "TopCityWeatherCell"
    
    let weatherIcon: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        return label
    }()
    
    lazy var locationStackView: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.addArrangedSubview(cityLabel)
        sv.addArrangedSubview(countryLabel)
        sv.axis = .vertical
        return sv
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(weatherIcon)
        contentView.addSubview(locationStackView)
        contentView.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            weatherIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            weatherIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            weatherIcon.heightAnchor.constraint(equalToConstant: Styles.Sizes.weatherIconSize.height),
            weatherIcon.widthAnchor.constraint(equalToConstant: Styles.Sizes.weatherIconSize.width)
        ])
        
        NSLayoutConstraint.activate([
            locationStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            locationStackView.leftAnchor.constraint(equalTo: weatherIcon.rightAnchor, constant: 20),
            locationStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            temperatureLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: TopCityWeather) {
        cityLabel.text = model.EnglishName
        countryLabel.text = model.Country.EnglishName
        weatherIcon.image = UIImage(named: String(model.WeatherIcon))
        
        let backgroundColor = model.IsDayTime ? Styles.Colors.day : Styles.Colors.night
        contentView.backgroundColor = backgroundColor
        
        let textColor = model.IsDayTime ? Styles.Colors.night : Styles.Colors.day
        cityLabel.textColor = textColor
        countryLabel.textColor = textColor
        
        
        var temperatureAttributedString: NSMutableAttributedString {
            let attributedString = NSMutableAttributedString(string: String(format: "%0.1f℃", model.Temperature.Metric.Value),
                                                attributes: [NSAttributedString.Key.foregroundColor: textColor]
            )

            attributedString.setAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 26),
                               NSAttributedString.Key.foregroundColor: textColor],
                              range: NSRange(location: 0, length: attributedString.string.count - 1)
            )
            return attributedString
        }
        temperatureLabel.attributedText = temperatureAttributedString
    }
    
}
