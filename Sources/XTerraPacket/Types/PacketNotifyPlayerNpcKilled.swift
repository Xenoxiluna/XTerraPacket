//
//  PacketNotifyPlayerNpcKilled.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketNotifyPlayerNpcKilled: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .NotifyPlayerNpcKilled
    public var payload: [UInt8] = []
    public var npcId: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.npcId = try reader.readInt16()
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
