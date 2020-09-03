//
//  NetModuleChat.swift
//  
//
//  Created by Quentin Berry on 7/15/20.
//

import Foundation
import SwiftyBytes

/// This is a struct for the ChatCommand NetModule.
public struct NetModuleChat: NetModule{
    public var command: ChatCommandType = .Emote
    public var commandData: ChatCommandData = ClientMsg.init()
    
    public init(){}
    
    /**
    Call this function to initialize the NetModule with Client message data.
     - Parameters:
        - command : The vanilla chat command you wish to perform as a NetModuleChat.ChatCommandType
        - message : The Chat Message String to send.
     
    ### Usage Example: ###
    ````
    var load = PacketLoadNetModule()
    load.netModuleType = .Chat
    load.netModule = NetModuleChat(command: .Say, message: "this is a test")
    do{
        try load.encode()
    }catch {}
    ````
    */
    public init(command: ChatCommandType, message: String){
        self.command = command
        self.commandData = ClientMsg.init(message: message)
    }
    
    public mutating func decode(_ reader: BinaryReader, _ context: TerrariaPacketContext) throws{
        if let c = ChatCommandType.init(rawValue: try reader.readVariableLengthString(.utf8).trimmingCharacters(in: .controlCharacters)){
            self.command = c
        }
        switch self.command{
        case .Say:
            if context == .ClientToServer{
                self.commandData = ClientMsg.init(message: try reader.readVariableLengthString(.utf8))
            }else{
                self.commandData = ServerMsg.init(author: try reader.readUInt8(), message: try reader.readVariableLengthString(.utf8), colorR: try reader.readUInt8(), colorG: try reader.readUInt8(), colorB: try reader.readUInt8())
            }
            return
        case .Emoji:
            return
        case .Emote:
            return
        case .Help:
            return
        case .Party:
            return
        case .Playing:
            return
        case .Roll:
            return
        case .RPS:
            return
        }
    }
    public mutating func encode(_ writer: BinaryWriter, _ context: TerrariaPacketContext) throws{
        try writer.writeVariableLengthString(command.rawValue, .utf8)
        switch self.command{
        case .Say:
            if context == .ClientToServer{
                try writer.writeVariableLengthString((commandData as! ClientMsg).message , .utf8)
            }else{
                try writer.writeUInt8((commandData as! ServerMsg).author)
                try writer.writeVariableLengthString((commandData as! ServerMsg).message, .utf8)
                try writer.writeUInt8((commandData as! ServerMsg).colorR)
                try writer.writeUInt8((commandData as! ServerMsg).colorG)
                try writer.writeUInt8((commandData as! ServerMsg).colorB)
            }
            return
        case .Emoji:
            return
        case .Emote:
            return
        case .Help:
            return
        case .Party:
            return
        case .Playing:
            return
        case .Roll:
            return
        case .RPS:
            return
        }
    }
    
    public enum ChatCommandType: String{
        case Say = "Say"
        case Emote = "Emote"
        case Roll = "Roll"
        case Party = "Party"
        case Playing = "Playing"
        case Help = "Help"
        case RPS = "RPS"
        case Emoji = "Emoji"
    }
    
    public struct ClientMsg: ChatCommandData{
        public var message: String = ""
    }
    
    public struct ServerMsg: ChatCommandData{
        public var author: UInt8
        public var message: String
        public var colorR: UInt8
        public var colorG: UInt8
        public var colorB: UInt8
    }
}
