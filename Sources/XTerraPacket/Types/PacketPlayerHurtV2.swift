//
//  PacketPlayerHurtV2.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

//incomplete

import Foundation
import SwiftyBytes

public struct PacketPlayerHurtV2: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .PlayerHurtV2
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var hitDirection: UInt8 = 0
    public var damage: Int16 = 0
    public var pvp: Bool = false
    public var deathText: String = ""
    
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
