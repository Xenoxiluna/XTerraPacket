//
//  PacketMinionAttackTargetUpdate.swift
//
//
//  Created by Quentin Berry on 5/7/20.
//

import Foundation
import SwiftyBytes

public struct PacketMinionAttackTargetUpdate: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var packetType: TerrariaPacketType = .MinionAttackTargetUpdate
    public var payload: [UInt8] = []
    public var playerId: UInt8 = 0
    public var minionAttackTarget: Int16 = 0
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryReadableData(data: self.payload)
        let reader = BinaryReader(data)
        self.playerId = try reader.readUInt8()
        self.minionAttackTarget = try reader.readInt16()
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt8(playerId)
        try writer.writeInt16(minionAttackTarget)
        payload.append(contentsOf: writer.data)
    }
}
