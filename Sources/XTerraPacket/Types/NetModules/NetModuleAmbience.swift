//
//  NetModuleAmbience.swift
//  
//
//  Created by Quentin Berry on 7/16/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the Ambience NetModule.
public struct NetModuleAmbience: NetModule{
    public var playerId: UInt8 = 0
    public var number: Int32 = 0
    public var type: UInt8 = 0

    public init(){}

    public init(playerId: UInt8, number: Int32, type: UInt8){
        self.playerId = playerId
        self.number = number
        self.type = type
    }

    public mutating func decode(_ reader: BinaryReader, _ context: TerrariaPacketContext) throws{
        self.playerId = try reader.readUInt8()
        self.number = try reader.readInt32()
        self.type = try reader.readUInt8()
    }
    public mutating func encode(_ writer: BinaryWriter, _ context: TerrariaPacketContext) throws{
        try writer.writeUInt8(self.playerId)
        try writer.writeInt32(self.number)
        try writer.writeUInt8(self.type)
    }
}
