//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by rajeev on 3/11/19.
//  Copyright © 2019 rajeev. All rights reserved.
//

import Foundation

struct Question {
    var text : String
    var type : ResponseType
    var answers : [Answer]
    
}

enum ResponseType {
    case single, multiple, ranged
}


struct Answer {
    var text : String
    var type : AnimalType
}

enum AnimalType : Character{
    case dog = "🐶"
    case cat = "🐱"
    case monkey = "🐒"
    case turtle = "🐢"
    
    var definition : String {
        switch self {
        case .dog :
            return "You are incredibly outgoing. You surround yourself with the people you love and enjoy activities with your friends."
        case .cat:
            return "“Mischievous, yet mild-tempered, you enjoy doing things on your own terms."
        case .monkey:
            return "You are healthy and full of energy"
        case .turtle:
            return "You are wise beyond the years. You have focus on details. Slow and steady wins the details"
        }
    }
}


