//
//  Parser.swift
//  HackAssembler
//
//  Parser: Encapsulates access to the input code. Reads an assembly language command,
//  parses it, and provides convenient access to the command’s components
//  (fields and symbols). In addition, removes all white space and comments.
//
//  Created by Rohini Kumar Barla on 26-06-16.
//  Copyright © 2016 Personal. All rights reserved.
//

import Foundation

enum CommandType {
    case A_Command
    case C_Command
    case L_Command
}

class Parser {

    var instructions: [String] = []
    var totalInstructions: Int = 0
    var currentInstructionPosition: Int = -1 // position starts with zero
    var currentInstructionType: CommandType = CommandType.A_Command
    var destMnemonic: String = "null"
    var jumpMnemonic: String = "null"
    var compMnemonic: String = "null"
    var instructionSymbol: String = "null"
    let symbolTable = SymbolTable.sharedInstance

    //
    // Opens the input file/stream and gets ready to parse it.
    //
    required init(filePath: String) {
        var asmCode: String = ""
        do {
            asmCode = try String(contentsOfFile: filePath)

        } catch _ {
            print("failed");
        }

        let lines = asmCode.components(separatedBy: "\n")

        //
        // Here in this code, we are doing the first pass of the assembler
        //
        for line in lines {
            var code = line.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            if code.contains("//") {
                let segments = code.components(separatedBy: "//")
                code = segments[0].trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)  // ignoring any comments like this one
            }

            if code.characters.count < 2 {
                // nothing
            } else {
                // valid instruction, add to instructions
                if code.hasPrefix("(") {
                    let lable = code.trimmingCharacters(in: CharacterSet(charactersIn: "()"))
                    symbolTable.addEntry(symbol: lable, address: instructions.count)
                    // Skipping the lable comamnd type for now
                    // FIXME: fix the above
                } else {
                    instructions.append(code)
                }
            }
        }
        // for debugging
        // print(instructions, separator: "", terminator: "\n")
        totalInstructions = instructions.count
    }

    //
    // Are there more commands in the input?
    //
    func hasMoreCommands() -> Bool {
        return (currentInstructionPosition + 1 < totalInstructions)
    }

    // 
    // Reads the next command from
    // the input and makes it the current command. Should be called only
    // if hasMoreCommands() is true. Initially there is no current command.
    //
    func advance() {
        currentInstructionPosition += 1
        parseCurrentInstruction()
    }

    //
    // Returns the type of the current command:
    // A_COMMAND for @Xxx where Xxx is either a symbol or a decimal number
    // C_COMMAND for dest=comp;jump
    // L_COMMAND (actually, pseudo- command) for (Xxx) where Xxx is a symbol.
    //
    func commandType() -> CommandType {
        return currentInstructionType
    }

    //
    // Returns the symbol or decimal Xxx of the current command @Xxx or (Xxx).
    // Should be called only when commandType() is A_COMMAND or L_COMMAND.
    //
    func symbol() -> String {
        return instructionSymbol
    }

    //
    // Returns the dest mnemonic in the current C-command (8 possibilities).
    // Should be called only when commandType() is C_COMMAND.
    //
    func dest() -> String {
        return destMnemonic
    }

    //
    // Returns the comp mnemonic in the current C-command (28 possibilities).
    // Should be called only when commandType() is C_COMMAND.
    //
    func comp() -> String {
        return compMnemonic
    }

    //
    // Returns the jump mnemonic in the current C-command (8 possibilities).
    // Should be called only when commandType() is C_COMMAND.
    //
    func jump() -> String {
        return jumpMnemonic
    }

    func parseCurrentInstruction() {
        let currentInstruction = instructions[currentInstructionPosition]
        if currentInstruction.hasPrefix("@") {
            // A-Instruction
            let aCodes = currentInstruction.components(separatedBy: "@")
            currentInstructionType = CommandType.A_Command
            instructionSymbol = aCodes[1]
        } else {
            // C-Instruction
            currentInstructionType = CommandType.C_Command
            var remainingCode = currentInstruction
            if remainingCode.contains(";") {
                // has jump instruction
                let cCodes = remainingCode.components(separatedBy: ";")
                // capture jump code
                jumpMnemonic = cCodes[1]
                remainingCode = cCodes[0]
                //print(remaniningCode)
            } else {
                jumpMnemonic = "null"
            }

            if remainingCode.contains("=") {
                // has destination code e.g. D=A-1
                let cCodes = remainingCode.components(separatedBy: "=")
                // capture dest code
                destMnemonic = cCodes[0]
                remainingCode = cCodes[1]
                // print(remaniningCode)
            } else {
                // no assignment operator, so dest is null
                destMnemonic = "null"
            }

            // remaining is computeCode
            compMnemonic = remainingCode
        }
    }
}



































