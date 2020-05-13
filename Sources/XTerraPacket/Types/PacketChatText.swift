//
//  PacketChatText.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

// INCOMPLETE

import Foundation
import SwiftyBytes

public struct PacketChatText: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .ChatText
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var messageColorR: UInt8 = 0
    public var messageColorG: UInt8 = 0
    public var messageColorB: UInt8 = 0
    public var message: String = ""
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        print("Not Implemented")
    }
    public func encoded() -> [UInt8]{
        print("Not Implemented")
        return []
    }
    mutating public func encode(){
        print("Not Implemented")
    }
    public func getLength(){
        print("Not Implemented")
    }
}
