//
//  PacketTileSendSquare.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketTileSendSquare: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .TileSendSquare
    public var payload: [UInt8] = []
    public var playerId: UInt16 = 0
    public var tileChangeType: UInt8 = 0
    public var size: Int16 = 0
    public var tileX: Int16 = 0
    public var tileY: Int16 = 0
    public var tilePayload: [UInt8] = []
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt16()

        let num: Int = 32768
        let num2: Int = Int(Int(self.playerId) & num) > 0 ? 1 : 0

        if (num2 != 0){
            self.tileChangeType = try reader.readUInt8()
        }

        self.size = try reader.readInt16()
        self.tileX = try reader.readInt16()
        self.tileY = try reader.readInt16()

        self.tilePayload = try reader.read(reader.data.data.count - reader.readIndex)
    }
    mutating public func encodePayload() throws{
        print("Not Implemented")
    }
}
