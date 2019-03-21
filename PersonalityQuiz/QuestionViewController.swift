//
//  QuestionViewController.swift
//  PersonalityQuiz
//
//  Created by rajeev on 3/10/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet weak var singleButton1: UIButton!
    @IBOutlet weak var singleButton2: UIButton!
    @IBOutlet weak var singleButton3: UIButton!
    @IBOutlet weak var singleButton4: UIButton!
    
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet weak var multiLabel1: UILabel!
    @IBOutlet weak var multiLabel2: UILabel!
    @IBOutlet weak var multiLabel3: UILabel!
    @IBOutlet weak var multiLabel4: UILabel!
    
    
    @IBOutlet weak var multiSwitch1: UISwitch!
    @IBOutlet weak var multiSwitch2: UISwitch!
    @IBOutlet weak var multiSwitch3: UISwitch!
    @IBOutlet weak var multiSwitch4: UISwitch!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var rangedLabel1: UILabel!
    @IBOutlet weak var rangedLabel2: UILabel!
    @IBOutlet weak var rangedSlider: UISlider!
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
   
    
    
    var questionIndex = 0
    
    var question : [Question] = [
      
        Question(text : "How much do you enjoy Car rides", type: .ranged,
                 answers: [
                    Answer(text: "I love them", type: .dog),
                    Answer(text: "I get a little nervous", type: .cat),
                    Answer(text: "I like them", type: .monkey),
                    Answer(text: "I barely notice them", type: .turtle)
            ]),
        Question(text : "Which activity do you enjoy", type: .multiple,
                 answers: [
                    Answer(text: "Swimming", type: .dog),
                    Answer(text: "Sleeping", type: .cat),
                    Answer(text: "Cuddling", type: .monkey),
                    Answer(text: "Eating", type: .turtle)
            ]),
        Question(text : "Which food do you like most", type: .single,
                 answers: [
                    Answer(text: "Steak", type: .dog),
                    Answer(text: "Fish", type: .cat),
                    Answer(text: "Carrot", type: .monkey),
                    Answer(text: "Corn", type: .turtle)
            ])
 
    ]
    
    var answersChosen : [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    func updateUI(){
        
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        
        navigationItem.title = "Question # \(questionIndex+1)"
       
        
        let currentQuestion = question[questionIndex]
        let currentAnswer = currentQuestion.answers
        let totalProgress =  (Float) (questionIndex / question.count)
        
        questionLabel.text = currentQuestion.text
        questionProgressView.setProgress(totalProgress, animated: true)
        
        switch currentQuestion.type {
        case .single:
            //singleStackView.isHidden = false
            updateSingleStack(using: currentAnswer)
        case .multiple:
           // multipleStackView.isHidden = false
            updateMultiStack(using: currentAnswer)
        case .ranged:
             //rangedStackView.isHidden = false
            updateRangedStack(using: currentAnswer)
        }
    }
    
    func updateSingleStack(using answers : [Answer]) {
        singleStackView.isHidden = false
        singleButton1.setTitle(answers[0].text, for: .normal)
        singleButton2.setTitle(answers[1].text, for: .normal)
        singleButton3.setTitle(answers[2].text, for: .normal)
        singleButton4.setTitle(answers[3].text, for: .normal)
    }
    
    func updateMultiStack(using answers : [Answer]) {
        
        multipleStackView.isHidden = false
        multiSwitch1.isOn = false
        multiSwitch2.isOn = false
        multiSwitch3.isOn = false
        multiSwitch4.isOn = false
        multiLabel1.text = answers[0].text
        multiLabel2.text = answers[1].text
        multiLabel3.text = answers[2].text
        multiLabel4.text = answers[3].text
    }
    
    func updateRangedStack(using answers : [Answer]) {
        
        rangedStackView.isHidden = false
        rangedSlider.setValue(0.5, animated: false)
        rangedLabel1.text = answers.first?.text
        rangedLabel2.text = answers.last?.text
    }
    
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswer = question[questionIndex].answers
       
        switch sender {
            
        case singleButton1 :
            answersChosen.append(currentAnswer[0])
        
        case singleButton2 :
            answersChosen.append(currentAnswer[1])
        
        case singleButton3 :
            answersChosen.append(currentAnswer[2])
        
        case singleButton4 :
            answersChosen.append(currentAnswer[3])
     
        default:
            break
        }
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        
        let currentAnswer = question[questionIndex].answers
        
        if multiSwitch1.isOn{
            answersChosen.append(currentAnswer[0])
        }
        if multiSwitch2.isOn{
            answersChosen.append(currentAnswer[1])
        }
        if multiSwitch3.isOn{
            answersChosen.append(currentAnswer[2])
        }
        if multiSwitch4.isOn{
            answersChosen.append(currentAnswer[3])
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let currentAnswers = question[questionIndex].answers
        let index = Int(round(rangedSlider.value *
            Float(currentAnswers.count - 1)))
        answersChosen.append(currentAnswers[index])
        nextQuestion()
        }
    
    func nextQuestion(){
        questionIndex += 1
        
        if questionIndex < question.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "ResultSegue") {
            let resultViewController = segue.destination as! ResultViewController
            resultViewController.responses = answersChosen
        }
    }
    

}
