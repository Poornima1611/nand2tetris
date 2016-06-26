//
//  main.swift
//  HackAssembler
//
//  Created by Rohini Kumar Barla on 26-06-16.
//  Copyright © 2016 Personal. All rights reserved.
//

import Foundation

/*
 First Pass Go through the entire assembly program, line by line, and build the
 symbol table without generating any code. As you march through the program lines,
 keep a running number recording the ROM address into which the current command
 will be eventually loaded. This number starts at 0 and is incremented by 1 whenever
 a C-instruction or an A-instruction is encountered, but does not change when a label
 pseudocommand or a comment is encountered. Each time a pseudocommand (Xxx)
 is encountered, add a new entry to the symbol table, associating Xxx with the ROM
 address that will eventually store the next command in the program. This pass results
 in entering all the program’s labels along with their ROM addresses into the symbol
 table. The program’s variables are handled in the second pass.
*/

func firstPass(fileName:String) {

}


/*
 Second Pass Now go again through the entire program, and parse each line. Each
 time a symbolic A-instruction is encountered, namely, @Xxx where Xxx is a symbol
 and not a number, look up Xxx in the symbol table. If the symbol is found in the
 table, replace it with its numeric meaning and complete the command’s translation.
 If the symbol is not found in the table, then it must represent a new variable. To
 handle it, add the pair (Xxx, n) to the symbol table, where n is the next available
 RAM address, and complete the command’s translation. The allocated RAM
 addresses are consecutive numbers, starting at address 16 (just after the addresses
 allocated to the predefined symbols).
*/

func secondPass(filePath:String) {

    let codeGen = Code()
    let parser = Parser(filePath: filePath)
    let symbolTable = SymbolTable.sharedInstance
    var currentVariableAddress = 16

    while parser.hasMoreCommands() {
        parser.advance()
        switch parser.commandType() {
        case CommandType.A_Command:
            // print A Command
            // print the number with 0 + 15 binary format
            let symbol = parser.symbol()

            let address: Int
            if let number = Int(symbol) {
                // it's number
                address = number
            } else {
                // it's symbol
                if symbolTable.contains(symbol: symbol) {
                    address = symbolTable.getAddress(symbol: symbol)
                } else {
                    address = currentVariableAddress // assign the latest available addr to variable
                    currentVariableAddress += 1

                    // add the variable entry
                    symbolTable.addEntry(symbol: symbol, address: address)
                }
            }
            let aCode = String(address, radix:2)
            let padd = String(repeating: Character("0"), count: 16 - aCode.characters.count)
            print(padd + aCode)

        case CommandType.C_Command:
            // print C Command
            var resultCode = "111"
            resultCode += codeGen.comp(mnemonic: parser.compMnemonic)
            resultCode += codeGen.dest(mnemonic: parser.destMnemonic)
            resultCode += codeGen.jump(mnemonic: parser.jumpMnemonic)
            print(resultCode)
        case CommandType.L_Command:
            // nothing for now
            print("Not handling labels cases")
        }
    }
}

func process(_ filePath:String) {
    secondPass(filePath: filePath);
}

// Goal:
// Read the .asm file
// convert
// output to .hack file

if (Process.arguments.count < 2 || Process.arguments.count > 2) {
    print("Usage:", "HackAssemble <file path of .asm file>", separator: "\n", terminator: "\n")
} else {
    let filePath = Process.arguments[1]
    // debug
    // print("Given ASM file path: \(filePath) \n")
    process(filePath)
}
