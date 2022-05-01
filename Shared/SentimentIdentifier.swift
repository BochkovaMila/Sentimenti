//
//  SentimentIdentifier.swift
//  NLPApp
//
//  Created by Mila B on 30.04.2022.
//

import Foundation
import SwiftUI
import CoreML
import NaturalLanguage


class SentimentIdentifier: ObservableObject {
    
    @Published var prediction = ""
    @Published var confidence = 0.0
    
    var model = MLModel()
    var sentimentPredictor = NLModel()
    
    init(){
        
        do {
            let sentimentModel = try SentimentClassifier(configuration: MLModelConfiguration()).model
            self.model = sentimentModel
            do {
                let predictor = try NLModel(mlModel: model)
                self.sentimentPredictor = predictor
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
        
    }
    
    
    func predict(_ text: String) {
        
        self.prediction = sentimentPredictor.predictedLabel(for: text) ?? ""
        let predictionSet = sentimentPredictor.predictedLabelHypotheses(for: text, maximumCount: 1)
        self.confidence = predictionSet[prediction] ?? 0.0
        
    }
    
}
