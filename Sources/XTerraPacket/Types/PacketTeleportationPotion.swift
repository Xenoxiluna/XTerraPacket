//
//  PacketTeleportationPotion.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTeleportationPotion: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TeleportationPotion
    public var payload: [UInt8] = []
    public var potionType: UInt8 = 0
    
    public init(){}
    
    /*
        case 0: TeleportationPotion()
        case 1: MagicConch()
        case 2: DemonConch()
    */
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        self.potionType = try reader.readUInt8()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(potionType)
        payload.append(contentsOf: writer.data.bytes)
    }
}
