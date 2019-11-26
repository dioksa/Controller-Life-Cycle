//
//  ViewController.swift
//  ControllersLifeCycle
//
//  Created by Oksana Dionisieva on 11/25/19.
//  Copyright © 2019 dioksa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private weak var currentController: SecondViewController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Если ссылку на контроллер не сделать weak, то SecondViewController из памяти не удалится
        // Удалился контроллер или нет можно легко проверить, если зайти в Debug Inspector и нажать на View Memory Graph Hierarchy, SecondViewController там быть не должно
        print(currentController as Any)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondViewController" {
            if let destinationVC = segue.destination as? SecondViewController {
                currentController = destinationVC
                destinationVC.modalPresentationStyle = .fullScreen
            }
        }
    }
}
