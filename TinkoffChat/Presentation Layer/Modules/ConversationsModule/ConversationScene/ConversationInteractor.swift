//
//  ConversationInteractor.swift
//  TinkoffChat
//
//  Created by st.i on 07/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit

//интерактор существует без презентера и вообще выполняет действия немного неправильно. создал его и перевел получение данных сюда исключительно на будущее и для разгрузки viewController

enum MessageType: Int {
    case incoming
    case outcoming
}

class ConversationMessageDisplayModel: NSObject {
    var message: String?
    var messageType: MessageType?
}

class ConversationInteractor: NSObject {
    static func createDisplayModels() -> [ConversationMessageDisplayModel] {
        let messages = ["Hello!",
                        "Hi!",
                        "You forgot keys.",
                        "They have really good terms of work there. Place and office are good.",
                        "I do not like this kind of music.",
                        "Yes! Car sounds crazy! My dreamcar!",
                        "Will you visit this event?",
                        "I saw that supercar near Kremlin. Man, that was awesome!",
                        "Yes, I met him yesterday near bus station))",
                        "Did u do your homework?",
                        "Next task will be harder, I suppose..",
                        "That was crazy win of CSKA!!!!!!",
                        "Oh it is so cold in September! Do not want October to come already..(",
                        "I saw that supercar near Kremlin. Man, that was awesome!",
                        "What about tonight?",
                        "Don't forget about birthday party ;)",
                        "I saw that supercar near Kremlin. Man, that was awesome!",
                        "Conor will win this great show and become richer :D",
                        "I don't understand all this big interest around this event",
                        "They just fight and that's all"]
        
        var displayModels = [ConversationMessageDisplayModel]()
        for i in 0..<20 {
            let displayModel = ConversationMessageDisplayModel()
            displayModel.message = messages[i]
            displayModel.messageType = MessageType.init(rawValue: Int.random(in: 0...2))
            displayModels.append(displayModel)
        }
        
        return displayModels
    }
}
