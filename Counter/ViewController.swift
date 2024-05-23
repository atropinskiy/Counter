//
//  ViewController.swift
//  Counter
//
//  Created by alex_tr on 20.05.2024.
//

import UIKit

class ViewController: UIViewController {
    private var counter: Int = 0
    private var text: String = "Значение изменено на -1"
    
    @IBOutlet weak var displayCounter: UILabel!
    @IBOutlet weak var increaseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var logWindow: UIScrollView!
    

    //    Функция для вывода сообщения в лог-окно. На вход принимает тип действия.
    private let topPadding: CGFloat = 5 // Отступ сверху

    private func sendLogToLogWindow(action: String) {
        // Получаем текущую дату и время
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let currentDateTime = dateFormatter.string(from: Date())
        
        // Создаем текст сообщения с датой и временем
        var textToLog: String
        if action == "increase" {
            textToLog = "\(currentDateTime) - Значение изменено на +1"
        } else if action == "decrease" {
            textToLog = "\(currentDateTime) - Значение изменено на -1"
        } else if action == "nullforbidden" {
            textToLog = "\(currentDateTime) - Попытка уменьшить значение счетчика ниже 0"
        } else if action == "start" {
            textToLog = "История изменений"
        } else {
            textToLog = "\(currentDateTime) - Счетчик сброшен"
        }
        
        // Создаем UILabel для текста сообщения
        let label = UILabel()
        label.text = textToLog
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0 // Разрешаем перенос на новую строку
        label.sizeToFit()
        
        // Устанавливаем ширину UILabel равной ширине лог-окна
        label.frame.size.width = logWindow.frame.size.width - 20 // 20 - отступы
        
        // Вычисляем высоту текста
        let textSize = label.sizeThatFits(CGSize(width: label.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        // Вычисляем положение UILabel с учетом отступов
        var labelFrame = label.frame
        labelFrame.size.height = textSize.height
        labelFrame.origin.x = 10 // Левый отступ
        labelFrame.origin.y = logWindow.contentSize.height + topPadding // Верхний отступ
        label.frame = labelFrame
        
        // Добавляем UILabel в лог-окно
        logWindow.addSubview(label)
        
        // Обновляем contentSize лог-окна
        logWindow.contentSize = CGSize(width: logWindow.contentSize.width, height: labelFrame.maxY + topPadding) // Добавляем верхний отступ
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.sendLogToLogWindow(action: "start")
    }
    
    @IBAction func increaseButtonClick(_ sender: Any) {
        counter += 1
        displayCounter.text = String(counter)
        self.sendLogToLogWindow(action: "increase")
        
        // Добавляем текст в UIScrollView

    }
    
    @IBAction func decreaseButtonClick(_ sender: Any) {
        if counter > 0 {
            counter -= 1
            displayCounter.text = String(counter)
            self.sendLogToLogWindow(action: "decrease")
        }
        else {
            self.sendLogToLogWindow(action: "nullforbidden")
        }
    }
    
    @IBAction func resetButtonClick(_ sender: Any) {
        counter = 0
        displayCounter.text = String(counter)
        self.sendLogToLogWindow(action: "reset")
    }
}



