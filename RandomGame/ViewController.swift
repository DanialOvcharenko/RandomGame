//
//  ViewController.swift
//  RandomGame
//
//  Created by Mac on 11.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var underTopLabel: UILabel!
    @IBOutlet weak var textFieldGame: UITextField!
    @IBOutlet weak var globalView: UIView!
    @IBOutlet weak var topView: UIView!
    
    
    static var games = ["Бура", "Ведьма", "Верю не верю", "Дурак", "Манчкин", "Сундучок", "Шахматы", "Шашки" ]
    var game : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let data = UserDefaults.standard.object(forKey: "game") as? [String] {
            ViewController.games = data
        }
        //подтягиваем данные из ЮзерДефолтс в массив
        
        let path = UIBezierPath(roundedRect:topView.bounds, byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: gameView.bounds.height / 9, height: 1))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        topView.layer.mask = maskLayer
        
        globalView.layer.cornerRadius = gameView.bounds.height / 9
        globalView.layer.borderWidth = 2
        globalView.layer.borderColor = UIColor.black.cgColor
        globalView.backgroundColor = UIColor.white
        
        button.layer.cornerRadius = button.bounds.height / 2
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        
        gameView.layer.cornerRadius = gameView.bounds.height / 5
        gameView.layer.borderWidth = 2
        gameView.layer.borderColor = UIColor.black.cgColor
        
        underTopLabel.text = "нажимаешь кнопку и он предлагает игру из списка игр"
        
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        label.text = ViewController.games.randomElement()
        
    }
    
    
    @IBAction func addButtonPressed(_ sender: Any) {
        
        guard let str = textFieldGame.text else { return }
        var check = true
        
        if str.contains(",") || str.contains(".") || str.contains("/") || str.contains("!") || str.contains("?") || str.contains(";") || str.contains(":") || str.contains("*") || str.contains("^") || str.contains("'") || str.contains("<") || str.contains(">") || str.contains("`") || str.contains("-") || str.contains("_") || str.contains("+") || str.contains("=") || str.contains("[") || str.contains("]") || str.contains("{") || str.contains("}") || str.contains("~") {
            check = false
        }
        
        if textFieldGame.text == "" || textFieldGame.text?.first == " " || textFieldGame.text?.first?.isUppercase == false || textFieldGame.text?.last == " " || check == false {
                
            let alert = UIAlertController(title: "Внимание" , message: "Ты нарушил правила, прочитай внимательнее сверху", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (alert) in
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
                
            textFieldGame.text = ""
        } else {
            game = textFieldGame.text ?? "ошибка"
            ViewController.games.append(game)
            
            UserDefaults.standard.set(ViewController.games, forKey: "game")
            //Обновление ЮзерДефолтс по ключу сразу после добавления новых данных
            
            print(ViewController.games)
                
            displayAlert(message: "Ты добавил новую игру в список")
                
            textFieldGame.text = ""
        }
    }
        
        
        
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "Супер",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

