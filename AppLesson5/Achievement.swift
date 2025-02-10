//
//  Achievement.swift
//  AppLesson5
//
//  Created by Даниил Суханов on 05.02.2025.
//

import UIKit
import Fakery

fileprivate let faker = Faker()

struct Achievement {
    let title: String
    let description: String
    let iconName: String
    let color: UIColor
    let progressBar: Float
    var isFinished: Bool {
        progressBar >= 100
    }
    
    static var demoData: [Achievement] {
        return [
            Achievement(
                title: "Мировой исследователь",
                description: "Посетил 150+ стран на 6 континентах",
                iconName: "globe.europe.africa.fill",
                color: .systemTeal,
                progressBar: 100
            ),
            Achievement(
                title: "Фотограф года",
                description: "Выложил 1000+ фотографий с геолокациями",
                iconName: "camera.aperture",
                color: .systemOrange,
                progressBar: 100
            ),
            Achievement(
                title: "Альпинист",
                description: "Покорил 5 вершин выше 4000 метров",
                iconName: "mountain.2.fill",
                color: .systemIndigo,
                progressBar: 100
            ),
            Achievement(
                title: "Эко-герой",
                description: "Собрал 50 кг мусора во время путешествий",
                iconName: "leaf.fill",
                color: .systemGreen,
                progressBar: 100
            ),
            Achievement(
                title: "Фуд-эксперт",
                description: "Попробовал 30 национальных блюд",
                iconName: "fork.knife.circle.fill",
                color: .systemRed,
                progressBar: 100
            ),
            Achievement(
                title: "Культуролог",
                description: "Посетил 20 музеев и исторических мест",
                iconName: "books.vertical.fill",
                color: .systemPurple,
                progressBar: 100
            )
        ] + (0..<100).map { _ in Achievement.random() }
    }
}

extension Achievement {
    static func random() -> Achievement {
        return Achievement(
            title: faker.zelda.game(),
            description: faker.lorem.sentence(wordsAmount: .random(in: 15...40)),
            iconName: "xmark",
            color: UIColor(
                red: CGFloat.random(in: 0...255) / 255.0,
                green: CGFloat.random(in: 0...255) / 255.0,
                blue: CGFloat.random(in: 0...255) / 255.0,
                alpha: 1
            ),
            progressBar: Float.random(in: 0...150)
        )
    }
}

