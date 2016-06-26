//
//  SymbolTable.swift
//  HackAssembler
//
//  SymbolTable: Keeps a correspondence between symbolic labels and numeric addresses.
//
//  Created by Rohini Kumar Barla on 26-06-16.
//  Copyright © 2016 Personal. All rights reserved.
//

import Foundation

//
// There are three types of symbols in the Hack language:
// predefined symbols, labels, and variables.
//

class SymbolTable {

    static let sharedInstance = SymbolTable()

    private var table = ["SP": 0,
                         "LCL": 1,
                         "ARG": 2,
                         "THIS": 3,
                         "THAT": 4,
                         "R0": 0, "R1": 1, "R2": 2, "R3": 3, "R4": 4, "R5": 5,
                         "R6": 6, "R7": 7, "R8": 8, "R9": 9, "R10": 10,
                         "R11": 11, "R12": 12, "R13": 13, "R14": 14, "R15": 15,
                         "SCREEN": 16384,
                         "KBD": 24576]

    //
    // Initialization Initialize the symbol table with all the predefined symbols
    // and their pre-allocated RAM addresses, according to section 6.2.3. In Book.
    //
    required init() {

    // Predefined Symbols Any Hack assembly program is allowed to use the following
    // predefined symbols.
    // Label | RAM address | (hexa)
    //   SP     0            0x0000
    //  LCL     1            0x0001
    //  ARG     2            0x0002
    //  THIS    3            0x0003
    //  THAT    4            0x0004
    //  R0-R15 0-15          0x0000-f
    //  SCREEN 16384         0x4000
    //  KBD    24576         0x6000

    // Label Symbols The pseudo-command (Xxx) defines the symbol Xxx to refer to the
    // instruction memory location holding the next command in the program. A label
    // can be defined only once and can be used anywhere in the assembly program,
    // even before the line in which it is defined.

    // Variable Symbols Any symbol Xxx appearing in an assembly program that is not
    // predefined and is not defined elsewhere using the (Xxx) command is treated as
    // a variable. Variables are mapped to consecutive memory locations as they are 
    // first encountered, starting at RAM address 16 (0x0010).

    }

    //
    // Adds the pair (symbol, address) to the table.
    //
    func addEntry(symbol:String, address:Int) {
        table[symbol] = address
    }

    //
    // Does the symbol table contain the given symbol?
    //
    func contains(symbol:String) -> Bool {
        return table.keys.contains(symbol)
    }

    //
    // Returns the address associated with the symbol.
    //
    func getAddress(symbol:String) -> Int {
        return table[symbol]!
    }
}
