//
//  Code.swift
//  HackAssembler
//
//  Code: Translates Hack assembly language mnemonics into binary codes.
//
//  Created by Rohini Kumar Barla on 26-06-16.
//  Copyright © 2016 Personal. All rights reserved.
//

import Foundation

class Code {

    //
    // Returns the binary code of the comp mnemonic.
    // 7 bits
    //
    func comp(mnemonic:String) -> String {

        let mnemonicTable = ["0"    : "0101010",  "empty1"  : "1101010",
                             "1"    : "0111111",  "empty2"  : "1111111",
                             "-1"   : "0111010",  "empty3"  : "1111010",
                             "D"    : "0001100",  "empty4"  : "1001100",
                             "A"    : "0110000",
                             "M"    : "1110000",
                             "!D"   : "0001101",  "empty5"  : "1001101",
                             "!A"   : "0110001",
                             "!M"   : "1110001",
                             "-D"   : "0001111",  "empty6"  : "1001111",
                             "-A"   : "0110011",
                             "-M"   : "1110011",
                             "D+1"  : "0011111",  "empty7"  : "1011111",
                             "A+1"  : "0110111",
                             "M+1"  : "1110111",
                             "D-1"  : "0001110",  "empty8"  : "1001110",
                             "A-1"  : "0110010",
                             "M-1"  : "1110010",
                             "D+A"  : "0000010",
                             "D+M"  : "1000010",
                             "D-A"  : "0010011",
                             "D-M"  : "1010011",
                             "A-D"  : "0000111",
                             "M-D"  : "1000111",
                             "D&A"  : "0000000",
                             "D&M"  : "1000000",
                             "D|A"  : "0010101",
                             "D|M"  : "1010101"
                             ]

        return mnemonicTable[mnemonic]!;
    }

    //
    // Returns the binary code of the dest mnemonic.
    // 3 bits
    //
    func dest(mnemonic:String) -> String {

        var destCode = ""
        // d1 d2 d3     // bits
        // A  D  M      // target registers
        for targetRegister in ["A", "D", "M"] {

            if mnemonic.contains(targetRegister) {
                destCode += "1"
            } else {
                destCode += "0"
            }
        }

        return destCode;
    }


    //
    // Returns the binary code of the jump mnemonic.
    // 3 bits
    //
    func jump(mnemonic:String) -> String {

        /*
        jump    j1 j2 j3
        ----    --------
        null    000
        JGT     001
        JEQ     010
        JGE     011
        JLT     100
        JNE     101
        JLE     110
        JMP     111
        */
        let mnemonicTable = ["null"  : "000",
                             "JGT"   : "001",
                             "JEQ"   : "010",
                             "JGE"   : "011",
                             "JLT"   : "100",
                             "JNE"   : "101",
                             "JLE"   : "110",
                             "JMP"   : "111"]

        return mnemonicTable[mnemonic]!;
    }
}
