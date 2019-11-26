//
//  SecondViewController.swift
//  ControllersLifeCycle
//
//  Created by Oksana Dionisieva on 11/25/19.
//  Copyright © 2019 dioksa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func handleCloseButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad is called")
        view.backgroundColor = .red
        print("Constraint высоты уже инициализирован и равен ->", heightConstraint.constant)
        print("Текст у label был присвоен на storyboard и равен -> \(textLabel.text!)")
        // View полностью загрузилось, данный метод полезен для инициализации элементов
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear is called")
        view.backgroundColor = .white
        textLabel.text = "Красивый лес"
        print("Текст у label был изменен на - Красивый лес")
        // Если пользователь хочет изменить ранее установленный цвет или текст, он может сделать это в этом методе
        // Таким образом, ранее установлений цвет пользователь не увидит
        // Также, в этом методе можно скрывать или показывать элементы, а также обновлять данные
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews is called")
        // Метод срабатывает перед тем, как размер view поменяется под размер экрана
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews is called")
        // Метод срабатывает после того, как размер view изменился под размер экрана
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear is called")
        
        UIView.animate(withDuration: 2.0, animations: {
            self.textLabel.frame = CGRect(x: 20.0, y: 390.0, width: 335.0, height: 26.5)
        })
        // View полностью появилось на экране, это лучший метод для анимации
        // Если заменить цвет view на данном этапе (без viewWillAppear), то пользователь коротковременно увидит первоночальный цвет view, то-есть тот, который был присвоен или на storyboard или во viewDidLoad
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear is called")
        
        view.backgroundColor = .green
        textLabel.layer.removeAllAnimations()
        // Экран закрывается, но пользователь еще видит смену цвета
        // На этом этапе хорошо сохранять состояние скролла, останавливать таймер, прятать клавиатуру
        // View еще не удалено из памяти и находится в иерархии superview
        // (!) Именно после этого метода вызывается метод viewWillAppear у контроллера, который будет показан следующим, в данном случае - это ViewController
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear is called")
        // Цвет изменился, но пользователь этого уже не видит
        // На этом этапе можно отписываться от уведомлений
        // View уже удалено из иерархии superview
    }
    
    deinit {
        print("Controller is not in memory")
        // Помните, если контроллер ушел с поля зрения, это еще не значит, что он удалился из памяти
    }
}
