//
//  File.swift
//  
//
//  Created by Quentin Berry on 7/15/20.
//

import Foundation
import SwiftyBytes

public struct NetModuleChat: NetModule{
    public var command: ChatCommandType = .Emote
    public var message: String = ""
    
    public init(){}
    public init(command: ChatCommandType, message: String){
        self.command = command
        self.message = message
    }
    
    public mutating func decode(_ reader: BinaryReader) throws{
        if let c = ChatCommandType.init(rawValue: try reader.readVariableLengthString(.utf8)){
            self.command = c
        }
        switch self.command{
        case .Say:
            self.message = try reader.readVariableLengthString(.utf8)
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
    public mutating func encode(_ writer: BinaryWriter) throws{
        try writer.writeVariableLengthString(command.rawValue, .utf8)
        switch self.command{
        case .Say:
            try writer.writeVariableLengthString(message, .utf8)
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
        case Say = "\u{3}Say"
        case Emote = "\u{5}Emote"
        case Roll = "\u{4}Roll"
        case Party = "\u{5}Party"
        case Playing = "\u{7}Playing"
        case Help = "\u{4}Help"
        case RPS = "\u{3}RPS"
        case Emoji = "\u{5}Emoji"
    }
}
