//
//  MultipeerCommunicator.swift
//  TinkoffChat
//
//  Created by st.i on 27/10/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

import UIKit
import MultipeerConnectivity

protocol Communicator {
    func sendMessage(string: String, to userID: String, completionHandler: ((_ success: Bool, _ error: Error?) -> ())?)
    var delegate: CommunicatorDelegate? {get set}
    var online: Bool {get set}
}

protocol CommunicatorDelegate: class {
    //discovering
    func didFoundUser(userID: String, userName: String?)
    func didLostUser(userID: String)
    
    //errors
    func failedToStartBrowsingForUsers(error: Error)
    func failedToStartAdvertising(error: Error)
    
    //messages
    func didReceiveMessage(text: String, fromUser: String, toUser: String)
}

class MultipeerCommunicator: NSObject, Communicator {
    
    private let serviceType = "tinkoff-chat"
    private let localPeerID: MCPeerID = MCPeerID(displayName: UIDevice.current.name)
    private let discoveryInfo = ["userName": "Ivan Stefanov"]
    private let nearbyServiceAdvertiser: MCNearbyServiceAdvertiser
    private let nearbyServiceBrowser: MCNearbyServiceBrowser
    
    var delegate: CommunicatorDelegate?
    var online: Bool
    var sessions: [String: MCSession] = [String: MCSession]()
    
    lazy var localSession: MCSession = {
        let session = MCSession(peer: localPeerID)
        session.delegate = self
        return session
    }()
    
    init(communicatorDelegate: CommunicatorDelegate) {
        self.nearbyServiceAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerID, discoveryInfo: discoveryInfo, serviceType: serviceType)
        self.nearbyServiceBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceType)
        self.online = true
        
        super.init()

        self.delegate = communicatorDelegate
        self.nearbyServiceAdvertiser.delegate = self
        self.nearbyServiceBrowser.delegate = self
        self.nearbyServiceAdvertiser.startAdvertisingPeer()
        self.nearbyServiceBrowser.startBrowsingForPeers()
    }
    
    deinit {
        self.nearbyServiceAdvertiser.stopAdvertisingPeer()
        self.nearbyServiceBrowser.stopBrowsingForPeers()
    }
    
    func sendMessage(string: String, to userID: String, completionHandler: ((Bool, Error?) -> ())?) {
        let message = ["eventType": "TextMessage",
                       "messageId": generateMessageId(),
                            "text": string]
        do {
            let messageData = try JSONSerialization.data(withJSONObject: message, options: [])
            if let session = self.sessions[userID] {
                try session.send(messageData, toPeers: session.connectedPeers, with: .reliable)
            }
        } catch {
            completionHandler?(false, error)
        }
        completionHandler?(true, nil)
    }
    
    func generateMessageId() -> String {
        let string = "\(arc4random_uniform(UINT32_MAX))+\(Date.timeIntervalSinceReferenceDate)+\(arc4random_uniform(UINT32_MAX))".data(using: .utf8)?.base64EncodedString()
        return string!
    }
}

extension MultipeerCommunicator: MCSessionDelegate {
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            print("Connected to \(peerID) peer")
        case .notConnected:
            print("Did not connect to \(peerID) peer")
        default:
            break
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        do {
            if let receivedData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                delegate?.didReceiveMessage(text: receivedData["text"] as! String, fromUser: peerID.displayName, toUser: localPeerID.displayName)
            }
        } catch {
            print("Didn't receive data")
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print(#function)
    }
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print(#function)
    }
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        print(#function)
    }
}

extension MultipeerCommunicator: MCNearbyServiceAdvertiserDelegate {
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        delegate?.failedToStartAdvertising(error: error)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        var session = self.sessions[peerID.displayName]
        if session == nil {
            session = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .none)
            session!.delegate = self
            self.sessions[peerID.displayName] = session
        }
        
        invitationHandler(true, session)
    }
}

extension MultipeerCommunicator: MCNearbyServiceBrowserDelegate {
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        delegate?.failedToStartBrowsingForUsers(error: error)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        guard peerID.displayName != localPeerID.displayName else {
            return
        }
        
        guard let userInfo = info else {
            return
        }
        
        guard let userName = userInfo["userName"] else {
            return
        }
        
        var session = sessions[peerID.displayName]
        if session == nil {
            session = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .none)
            session!.delegate = self
            sessions[peerID.displayName] = session
        }
        browser.invitePeer(peerID, to: session!, withContext: nil, timeout: 20)
        delegate?.didFoundUser(userID: peerID.displayName, userName: userName)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.didLostUser(userID: peerID.displayName)
    }
}
