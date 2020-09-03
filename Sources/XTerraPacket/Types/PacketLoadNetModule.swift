//
//  PacketLoadNetModule.swift
//  
//
//  Created by Quentin Berry on 5/5/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for LoadNetModule packets.
public struct PacketLoadNetModule: TerrariaPacket{
    public var bytes: [UInt8] = []
    public var length: UInt16 = 0
    public var context: TerrariaPacketContext = .ServerToClient
    public var packetType: TerrariaPacketType = .LoadNetModule
    public var payload: [UInt8] = []
    public var netModuleType: NetModuleType = .Liquid
    public lazy var netModule: NetModule = NetModuleChat()
    
    public init(){}
    
    public mutating func decodePayload() throws{
        if self.payload.isEmpty{
            try decodeHeader()
        }
        let data = BinaryData(data: self.payload)
        let reader = BinaryReader(data)
        if let m = NetModuleType.init(rawValue: try reader.readUInt16()){
            self.netModuleType = m
        }
        
        switch self.netModuleType{
        case .Ambience:
            self.netModule = NetModuleAmbience()
            try self.netModule.decode(reader, context)
        case .Bestiary:
            self.netModule = NetModuleBestiary()
            try self.netModule.decode(reader, context)
        case .Chat:
            self.netModule = NetModuleChat()
            try self.netModule.decode(reader, context)
        case .CreativePowerPermissions:
            self.netModule = NetModuleCreativePowerPermissions()
            try self.netModule.decode(reader, context)
        case .CreativePowers:
            self.netModule = NetModuleCreativePowers()
            try self.netModule.decode(reader, context)
        case .CreativeUnlocks:
            self.netModule = NetModuleCreativeUnlocks()
            try self.netModule.decode(reader, context)
        case .CreativeUnlocksReport:
            self.netModule = NetModuleCreativeUnlocksPlayerReport()
            try self.netModule.decode(reader, context)
        case .Liquid:
            self.netModule = NetModuleLiquid()
            try self.netModule.decode(reader, context)
        case .Particles:
            self.netModule = NetModuleParticles()
            try self.netModule.decode(reader, context)
        case .Ping:
            self.netModule = NetModulePing()
            try self.netModule.decode(reader, context)
        case .TeleportPylon:
            self.netModule = NetModuleTeleportPylon()
            try self.netModule.decode(reader, context)
        }
    }
    mutating public func encodePayload() throws{
        self.resetPayload()
        let writer = BinaryWriter()
        try writer.writeUInt16(netModuleType.rawValue)
        try self.netModule.encode(writer, context)
        payload.append(contentsOf: writer.data.bytes)
    }
    
    public enum NetModuleType: UInt16{
        case Liquid = 0
        case Chat = 1
        case Ping = 2
        case Ambience = 3
        case Bestiary = 4
        case CreativeUnlocks = 5
        case CreativePowers = 6
        case CreativeUnlocksReport = 7
        case TeleportPylon = 8
        case Particles = 9
        case CreativePowerPermissions = 10
    }
}
