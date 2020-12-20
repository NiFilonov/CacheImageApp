//
//  ViewController.swift
//  CacheImageApp
//
//  Created by Dragonborn on 20.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    // подключена tableView
    @IBOutlet weak var tableView: UITableView!
    
    // получаяем массив Симпсонов
    let persons = Storage().persons
    // НетворкМенеджер для работы с сетью
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Задаем делегат и датаСоурс для tableView
        tableView.delegate = self
        tableView.dataSource = self
    }

}

// Разделяем код, вынося методы TableView в отдельный extension
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        
        let person = persons[indexPath.row]
        
        // когда tableView попросит вернуть ячейку для конкретного IndexPath
        // запускаем загрузку картинки, когда картинка загрузится
        // отобразим это в соответствующей ячейке
        
        // картинки грузятся с разной скоростью и можно заметить
        // что сначала появляются все ячейки, чуть позже в разном
        // порядке отображаются имена и фотографии
        networkManager.download(from: person.photoURLString) { (image) in
            cell.photoView?.image = image
            cell.nameLabel.text = person.name
        }
        
        return cell
    }
    
    
}
