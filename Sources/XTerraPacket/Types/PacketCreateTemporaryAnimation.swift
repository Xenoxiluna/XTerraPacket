//
//  PacketCreateTemporaryAnimation.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketCreateTemporaryAnimation: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .CreateTemporaryAnimation
    public var payload: [UInt8] = []
    public var animationType: Int16 = 0
    public var tileType: UInt16 = 0
    public var x: Int16 = 0
    public var y: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.animationType = try reader.readInt16()
        self.tileType = try reader.readUInt16()
        self.x = try reader.readInt16()
        self.y = try reader.readInt16()
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
