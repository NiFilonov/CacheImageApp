//
//  NetworkManager.swift
//  CacheImageApp
//
//  Created by Dragonborn on 20.12.2020.
//

import Foundation
import UIKit

// этот класс имеет одну функцию - загрузить картинку по заданому URL
class NetworkManager {
    
    // получаем адрес картинки в виде строки и через замыкание возвращаем картинку
    func download(from urlString: String, handler: @escaping (UIImage) -> ()) {
        // создаем URL из строки
        if let url = URL(string: urlString) {
            
            // создаем сессию, через которую пойдет загрузка
            let session = URLSession(configuration: .default)
            
            // создаем задачу - загрузить картинку по URL и передать результат в замыкание
            let task = session.dataTask(with: url) { (data, response, error) in
                // если нет ошибки и пришли какие-то данные
                if error == nil && data != nil {
                    // поробуем данные конвертнуть в объект UIImage
                    if let image = UIImage(data: data!) {
                        // так как будет идети обновление на UI, вызываем главный поток
                        DispatchQueue.main.async {
                            // передаем картинку в замыкание
                            handler(image)
                        }
                    }
                } else {
                    print("error")
                }
            }
            // запускаем задачу
            task.resume()
        }
    }
    
}
