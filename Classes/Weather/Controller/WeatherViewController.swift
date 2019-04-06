//
//  WeatherViewController.swift
//  NSKeyedArchiverIntroduction
//
//  Created by Florian LUDOT on 3/26/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {
    
    let apiProvider: APIProvider
    
    var weatherFeed: WeatherFeed?
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        view.backgroundColor = UIColor.white
        setupTableView()
        loadTop50CitiesCurrentWeather()
    }
    
    @objc private func setupTableView() {
        tableView.dataSource = self
        tableView.register(TopCityWeatherCell.self, forCellReuseIdentifier: TopCityWeatherCell.identifier)
        tableView.rowHeight = Styles.Sizes.tableViewRowHeight
        tableView.allowsSelection = false
    }

    private func loadTop50CitiesCurrentWeather() {
        apiProvider.loadTop50CitiesCurrentWeather { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(var weatherFeed):
                let filteredTopCityWeathers = weatherFeed.topCityWeathers.sorted(by: { (left, right) -> Bool in
                    return left.EnglishName < right.EnglishName
                })
                weatherFeed.topCityWeathers = filteredTopCityWeathers
                strongSelf.weatherFeed = weatherFeed
                strongSelf.reloadData()
                
                do {
                    try NSKeyedArchiverManager.archive(object: strongSelf.weatherFeed!, toFile: NSKeyedArchiverManager.Paths.weatherFeed)
                } catch {
                    strongSelf.displayError(title: error.localizedDescription)
                }
            
            case .failure(let requestError):
                
                do {
                    if let weatherFeedUnarchived: WeatherFeed = try NSKeyedArchiverManager.unarchive(fromFile: NSKeyedArchiverManager.Paths.weatherFeed) {
                        strongSelf.weatherFeed = weatherFeedUnarchived
                        strongSelf.reloadData()
                    }
                    
                    strongSelf.displayError(title: requestError.localizedDescription)
                    
                } catch {
                    strongSelf.displayError(title: requestError.localizedDescription, message: error.localizedDescription)
                }
                
            }
        }
    }
    
    private func displayError(title: String?, message: String? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.showSimpleAlert(title: title, message: message)
        }
    }
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.reloadData()
        }
    }

}

extension WeatherViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _weatherFeed = self.weatherFeed else { return 0 }
        return _weatherFeed.topCityWeathers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TopCityWeatherCell.identifier) as! TopCityWeatherCell
        
        if let _weatherFeed = self.weatherFeed {
            let topCityWeather = _weatherFeed.topCityWeathers[indexPath.row]
            cell.configure(with: topCityWeather)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return weatherFeed?.fetchedAt
    }
    
}

