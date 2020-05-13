//
//  PacketSignNew.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketSignNew: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .SignNew
    public var payload: [UInt8] = []
    public var signId: Int16 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    public var text: String = ""
    public var playerId: UInt8 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.signId = try reader.readInt16()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
        self.text = try reader.read7BitEncodedString()
        self.playerId = try reader.readUInt8()
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
