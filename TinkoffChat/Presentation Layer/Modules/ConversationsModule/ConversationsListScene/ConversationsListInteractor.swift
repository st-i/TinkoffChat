//
//  ConversationsListInteractor.swift
//  TinkoffChat
//
//  Created by st.i on 06/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

//не бейте, пожалуйста, за то, что интерактор существует без презентера и вообще выполняет действия немного неправильно. создал его и перевел получение данных сюда исключительно на будущее и для разгрузки viewController :)

import UIKit

class ConversationDisplayModel: NSObject {
    var contactName: String?
    var message: String?
    var date: Date?
    var online: Bool?
    var hasUnreadMessages: Bool?
}

class ConversationsListInteractor: NSObject {
    static func createDisplayModels() -> [ConversationDisplayModel] {
        let names = ["Ivan Ivanov",
                     "Kirill Kirillov",
                     "Petr Petrov",
                     "Alex Alekseev",
                     "Sergey Sergeev",
                     "Artem Artamonov",
                     "Boris Borisov",
                     "Dmitriy Dmitriev",
                     "Alexandr Alexandrov",
                     "Ivan Alexandrov",
                     "Kirill Ivanov",
                     "Petr Sergeev",
                     "Alex Artamonov",
                     "Sergey Kirillov",
                     "Artem Artamonov",
                     "Boris Alexandrov",
                     "Dmitriy Borisov",
                     "Alexandr Alexandrov",
                     "Sergey Alekseev",
                     "Artem Dmitriev"]
        
        let messages = ["Hello!",
                        "Hi!",
                        "You forgot keys.",
                        "I do not like this kind of music.",
                        "Yes! Car sounds crazy! My dreamcar!",
                        "Will you visit this event?",
                        nil,
                        "Yes, I met him yesterday near bus station))",
                        nil,
                        "Did u do your homework?",
                        "Next task will be harder, I suppose..",
                        "That was crazy win of CSKA!!!!!!",
                        "Oh it is so cold in September! Do not want October to come already..(",
                        "I saw that supercar near Kremlin. Man, that was awesome!",
                        "What about tonight?",
                        "Don't forget about birthday party ;)",
                        "Conor will win this great show and become richer :D",
                        "I don't understand all this big interest around this event",
                        "They just fight and that's all",
                        "They have really good terms of work there. Place and office are good."]
        
        var lastMessagesDates = [Date]()
        for _ in 0..<15 {
            let currentCalendar = NSCalendar.current
            let hour = Int.random(in: 0..<23)
            let minute = Int.random(in: 0..<59)
            var components = currentCalendar.dateComponents([.day, .month, .year], from: Date())
            components.hour = hour
            components.minute = minute
            let lastMessageDate = currentCalendar.date(from: components)
            lastMessagesDates.append(lastMessageDate!)
        }
        lastMessagesDates.insert(Date().addingTimeInterval(-86400), at: 3)
        lastMessagesDates.insert(Date().addingTimeInterval(-86400 * 2), at: 7)
        lastMessagesDates.insert(Date().addingTimeInterval(-86400 * 3), at: 9)
        lastMessagesDates.insert(Date().addingTimeInterval(-86400 * 4), at: 11)
        lastMessagesDates.insert(Date().addingTimeInterval(-86400 * 5), at: 13)
        
        var onlineOrNotArray = [Bool]()
        for i in 0..<20 {
            if i < 10 {
                onlineOrNotArray.append(true)
            }else{
                onlineOrNotArray.append(false)
            }
        }
        
        var hasUnreadMessagesArray = [Bool]()
        for i in 0..<20 {
            if i < 10 {
                hasUnreadMessagesArray.append(true)
            }else{
                hasUnreadMessagesArray.append(false)
            }
        }
        
        var displayModelsArray = [ConversationDisplayModel]()
        for i in 0..<20 {
            let displayModel = ConversationDisplayModel()
            displayModel.contactName = names[i]
            displayModel.message = messages[i]
            displayModel.date = lastMessagesDates[i]
            displayModel.online = onlineOrNotArray[i]
            if displayModel.message == nil {
                displayModel.hasUnreadMessages = false
            }else{
                displayModel.hasUnreadMessages = hasUnreadMessagesArray[Int.random(in: 0..<20)]
            }
            displayModelsArray.append(displayModel)
        }
        
        return displayModelsArray
    }
}
