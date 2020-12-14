import Scanning._
import scala.io.StdIn.{readLine, readInt}
import scala.collection.mutable.ArrayBuffer
object Asm {
  /* A sequence of sequences of tokens, where each inside sequence represents a line.
   * For example, tokenLines(3)(4) is the fifth token on line 4.
   */
  type SymbolTable = Map[String, Int]
  var table : SymbolTable = Map[String, Int]()

  val tokenLines: Seq[Seq[Token]] = io.Source.stdin.getLines.map(scan).toSeq
  
  var validInstructions: List[String] = List(".word", "add", "sub", "mult", "multu", "div", "divu", "mfhi", "mflo", "lis", "lw", "sw", "slt", "sltu", "beq", "bne", "jr", "jalr")
  
  var PC : Int = 0

  def assemble(): Unit = {
    pass1()
    //clean_tokenLines()
    for (tokenLine <- tokenLines) {
      var linelength: Int = tokenLine.length

      //checking for empty tokenLine corresponding to empty lines
      if (linelength != 0) {
        var i: Int = 0

        //getting rid of all the labels
        while (tokenLine(i).kind == "LABEL" && i+1 != linelength) {
          //Console.err.println("Cleaned lable " + tokenLine(i).lexeme)
          i += 1
        }
        var tokenKind = tokenLine(i).kind
        var tokenValue = tokenLine(i).lexeme.toLowerCase
        
    	tokenKind match {
    		case "WORD" => 
    			if (linelength == i + 2) {
    				output_type_word(tokenLine(i + 1).kind, tokenLine(i + 1).lexeme)
    			}
    			else {
    				Console.err.println("ERROR PC=" + PC + ": .word only takes 1 input but passed " + (linelength - i - 1) + " input(s)")
    			}   
    		case "ID" => 
    			tokenValue match {
    				case "jr" | "jalr" => 
    					if (linelength == i + 2) {
    						output_type_jr(tokenLine(i + 1).kind, tokenLine(i + 1).lexeme, tokenValue)
    					}
    					else {
    						Console.err.println("ERROR PC=" + PC + ": " + tokenValue + " only takes 1 REG as input but passed " + (linelength - i - 1) + " input(s)")
    					}

    				case "add" | "sub" | "slt" | "sltu" =>
    					if (linelength == i + 6) {
    						if (tokenLine(i + 2).kind == "COMMA" && tokenLine(i + 4).kind == "COMMA") {
    							output_type_add(tokenLine(i + 1).kind, tokenLine(i + 3).kind, tokenLine(i + 5).kind, tokenLine(i + 1).lexeme, tokenLine(i + 3).lexeme, tokenLine(i + 5).lexeme, tokenValue)
    						}
    						else if (tokenLine(i+2).kind == "COMMA"){
    							Console.err.println("ERROR PC=" + PC + ": In " + tokenValue + " expecting COMMA but got: " + tokenLine(i + 4).kind + " with value: " + tokenLine(i + 4).lexeme)
    						}
    						else {
    							Console.err.println("ERROR PC=" + PC + ": In " + tokenValue + " expecting COMMA but got: " + tokenLine(i + 2).kind + " with value: " + tokenLine(i + 2).lexeme)
    						}
    					}
    					else {
    						Console.err.println("ERROR PC=" + PC + ": " + tokenValue + " takes 3 REG and 2 COMMAS as input but passed " + (linelength - i - 1) + " input(s) in total")
    					}
    				
    				case "beq" | "bne" => 
    					 if (linelength == i + 6) {
    						if (tokenLine(i + 2).kind == "COMMA" && tokenLine(i + 4).kind == "COMMA") {
    							output_type_beq(tokenLine(i + 1).kind, tokenLine(i + 3).kind, tokenLine(i + 5).kind, tokenLine(i + 1).lexeme, tokenLine(i + 3).lexeme, tokenLine(i + 5).lexeme, tokenValue)
    						}
    						else if (tokenLine(i+2).kind == "COMMA"){
    							Console.err.println("ERROR PC=" + PC + ": In " + tokenValue + " expecting COMMA but got: " + tokenLine(i + 4).kind + " with value: " + tokenLine(i + 4).lexeme)
    						}
    						else {
    							Console.err.println("ERROR PC=" + PC + ": In " + tokenValue + " expecting COMMA but got: " + tokenLine(i + 2).kind + " with value: " + tokenLine(i + 2).lexeme)
    						}
    					}
    					else {
    						Console.err.println("ERROR PC=" + PC + ": " + tokenValue + " takes 3 REG and 2 COMMAS as input but passed " + (linelength - i - 1) + " input(s) in total")
    					}

    				case "lis" |"mflo" | "mfhi" =>
    					if (linelength == i + 2) {
    						output_type_lis(tokenLine(i + 1).kind, tokenLine(i + 1).lexeme, tokenValue)
    					}
    					else {
    						Console.err.println("ERROR PC=" + PC + ": " + tokenValue + " only takes 1 REG as input but passed " + (linelength - i - 1) + " input(s)")
    					}


    				case "mult" | "multu" | "div" | "divu" =>
    					if (linelength == i + 4) {
    						if (tokenLine(i + 2).kind == "COMMA") {
    							output_type_mult(tokenLine(i + 1).kind, tokenLine(i + 3).kind, tokenLine(i+1).lexeme, tokenLine(i + 3).lexeme, tokenValue)
    						}
    						else {
    							Console.err.println("ERROR PC=" + PC + ": In " + tokenValue + " expecting COMMA but got: " + tokenLine(i + 2).kind + " with value: " + tokenLine(i + 2).lexeme)
    						}
    					}
    					else {
    						Console.err.println("ERROR PC=" + PC + ": " + tokenValue + " takes 2 REG and 1 COMMA as input but passed " + (linelength - i - 1) + " input(s)")
    					}

    				case "sw" | "lw" =>
    					if (linelength == i + 7) {
    						if (tokenLine(i+2).kind == "COMMA" && tokenLine(i+4).kind == "LPAREN" && tokenLine(i+6).kind == "RPAREN") {
    							output_type_sw(tokenLine(i + 1).kind, tokenLine(i + 3).kind, tokenLine(i + 5).kind, tokenLine(i + 1).lexeme, tokenLine(i + 3).lexeme, tokenLine(i + 5).lexeme, tokenValue)
    						}
    						else {
    							Console.err.println("ERROR PC=" + PC + ": Improper format for calling " + tokenValue + ", PROPER USE: " + tokenValue + " $t, i($s)")
    						}
    					}
              else {
                Console.err.println("ERROR PC=" + PC + ": " + tokenValue + " takes 2 REG, 1 COMMA, 1 INT/HEXINT enclosed in LPAREN and RPAREN as input but passed " + (linelength - i - 1) + " input(s)")
              }

    				case unexpectedValue => 
    					Console.err.println("ERROR PC=" + PC + ": invalid start of command, expecting an instruction but found an Invalid ID: " + unexpectedValue)
    			}
    		
    		case "LABEL" => //if we get here then it means that we are at the end of tokenLine and the last token is a LABEL so the line isnt relevant
    		case unexpectedKind => 
    			Console.err.println("ERROR PC=" + PC + ": invalid start of command, expecting an instruction but found an invalid Kind: " + unexpectedKind + " with Value: " + tokenValue)
    	}        
      } 
    }
    //output_symbol_table()
  }
  
  def output_type_sw(parameterKind1: String, parameterKind2:String, parameterKind3:String, parameterValue1:String, parameterValue2:String, parameterValue3:String, parameterType:String) : Unit = {
  	var instruction : Long = if ( parameterType == "sw") 0xac000000 else 0x8c000000
  	var parameterIntValue1 : Long = 0
  	var parameterIntValue2 : Long = 0
  	var parameterIntValue3 : Long = 0
  	(parameterKind1,parameterKind2,parameterKind3) match {
  		case ("REG","INT","REG") =>
  			parameterIntValue2 = parameterValue2.toLong
  			if (parameterIntValue2 < -32768 || parameterIntValue2 > 32767) {
  				Console.err.println("ERROR PC=" + PC + ": Integer Offset defined in " + parameterType + " should be between -32768 and 32767 (both inclusive) but found " + parameterIntValue2)
  				return
  			}
  		case ("REG","HEXINT","REG") =>
  			parameterIntValue2 = java.lang.Integer.parseUnsignedInt(parameterValue2.substring(2), 16).toLong
  			if (parameterIntValue2 < 0 ||parameterIntValue2 > 65535) {
  				Console.err.println("ERROR PC=" + PC + ": Hexadecimal Integer Offset defined in " + parameterType + " should be between 0 and 65535 (both inclusive) but found " + parameterIntValue2)
  				return
  			}
  		case unexpected => 
  			Console.err.println("ERROR PC=" + PC + ": Invalid Kind of parameter passed to " + parameterType + ", expecting (REG,INT/HEXINT,REG) but found: " + unexpected)
  			return
  	}
  	parameterIntValue1 = java.lang.Integer.parseUnsignedInt(parameterValue1.substring(1))
  	parameterIntValue3 = java.lang.Integer.parseUnsignedInt(parameterValue3.substring(1))
  	instruction = instruction | (parameterIntValue1 << 16)
  	instruction = instruction | (parameterIntValue3 << 21)
  	instruction = instruction | (parameterIntValue2 & 0xffff)
  	output_instruction(instruction)
  }

  def output_type_mult(parameterKind1: String, parameterKind2:String, parameterValue1:String, parameterValue2:String, parameterType:String) : Unit = {
  	(parameterKind1,parameterKind2) match {
  		case ("REG","REG") =>
  			var parameterIntValue1 : Long = java.lang.Integer.parseUnsignedInt(parameterValue1.substring(1))
  			var parameterIntValue2 : Long = java.lang.Integer.parseUnsignedInt(parameterValue2.substring(1))
  			var instruction : Long = parameterType match {
  				case "mult" => 0x18
  				case "multu" => 0x19
  				case "div" => 0x1a
  				case "divu" => 0x1b
  			}
  			instruction = instruction | (parameterIntValue1 << 21)
  			instruction = instruction | (parameterIntValue2 << 16)
  			output_instruction(instruction)

  		case unexpected =>
  			Console.err.println("ERROR PC=" + PC + ": Invalid Kind of parameter passed to " + parameterType + ", expecting (REG,REG) but found: " + unexpected)
  	}
  }

  def output_type_lis(parameterKind: String, parameterValue: String, parameterType: String) : Unit = {
  	parameterKind match {
  		case "REG" => 
  			var parameterIntValue = java.lang.Integer.parseUnsignedInt(parameterValue.substring(1)) 
			var instruction : Long = parameterType match {
				case "lis" => 0x14
				case "mflo" => 0x12
				case "mfhi" => 0x10
			}
			instruction = instruction | (parameterIntValue << 11)
			output_instruction(instruction)
  		
	  	case unexpected => 
	  		Console.err.println("ERROR PC=" + PC + ": Invalid Kind of parameter passed to " + parameterType + ", expecting REG(0-31) but found: " + parameterKind + " with value: " + parameterValue)
  	}
  }


  def output_type_beq(parameterKind1:String, parameterKind2:String, parameterKind3:String, parameterValue1:String, parameterValue2:String, parameterValue3:String, parameterType:String):Unit={
  	var instruction : Long = if (parameterType == "beq") 0x10000000 else 0x14000000 
  	var parameterIntValue1 : Long = 0
  	var parameterIntValue2 : Long = 0
  	var parameterIntValue3 : Long = 0
  	(parameterKind1,parameterKind2,parameterKind3) match {
  		case ("REG","REG","INT") =>
  			//Console.err.println("Came across type beq with (REG,REG,INT)")
  			parameterIntValue3 = parameterValue3.toLong
  			if (parameterIntValue3 < -32768 || parameterIntValue3 > 32767) {
  				Console.err.println("ERROR PC=" + PC + ": Integer Offset defined in " + parameterType + " should be between -32768 and 32767 (both inclusive) but found " + parameterIntValue3)
  				return
  			}

		case ("REG","REG","HEXINT") =>
			//Console.err.println("Came across type beq with (REG,REG,HEXINT)")
  			parameterIntValue3 = java.lang.Integer.parseUnsignedInt(parameterValue3.substring(2), 16).toLong
  			if (parameterIntValue3 < 0 || parameterIntValue3 > 65535) {
  				Console.err.println("ERROR PC=" + PC + ": Hexadecimal Integer Offset defined in " + parameterType + " should be between 0 and 65535 (both inclusive) but found " + parameterIntValue3)
  				return
  			}

		case ("REG","REG","ID") =>
			//Console.err.println("Came across type beq with (REG,REG,ID)")
			var labelValue = table.getOrElse(parameterValue3, -1)
	        if (labelValue == -1) {
	          Console.err.println("ERROR PC=" + PC + ": Invalid LABEL-ID(" + parameterValue3 + ") passed to " + parameterType + " (LABEL not defined)")
	        }
	        else {
	        	parameterIntValue3 = (labelValue - PC  - 4) / 4
	        	if (parameterIntValue3 < -32768 || parameterIntValue3 > 32767) {
					Console.err.println("ERROR PC=" + PC + ": Label Offset defined in " + parameterType + " should be between -32768 and 32767 (both inclusive) but found " + parameterIntValue3)
					return
				}
	        }

		case unexpected =>
			Console.err.println("ERROR PC=" + PC + ": Invalid parameters passed to " + parameterType + ", expecting (REG,REG,INT/HEXINT/LABEL-ID) but found: " + unexpected)
			return
  	}
  	parameterIntValue1 = java.lang.Integer.parseUnsignedInt(parameterValue1.substring(1)) 
  	parameterIntValue2 = java.lang.Integer.parseUnsignedInt(parameterValue2.substring(1)) 
  	instruction = instruction | (parameterIntValue1 << 21)
	instruction = instruction | (parameterIntValue2 << 16)
	instruction = instruction | (parameterIntValue3 & 0xffff)
	output_instruction(instruction)
		  	
  }

  def output_type_add(parameterKind1:String, parameterKind2:String, parameterKind3:String, parameterValue1:String, parameterValue2:String, parameterValue3:String, parameterType:String):Unit={
  	(parameterKind1,parameterKind2,parameterKind3) match {
  		case ("REG","REG","REG") =>
  			var parameterIntValue1 = java.lang.Integer.parseUnsignedInt(parameterValue1.substring(1)) 
  			var parameterIntValue2 = java.lang.Integer.parseUnsignedInt(parameterValue2.substring(1)) 
  			var parameterIntValue3 = java.lang.Integer.parseUnsignedInt(parameterValue3.substring(1)) 
			var instruction : Long = parameterType match {
				case "add" => 0x20
				case "sub" => 0x22
				case "slt" => 0x2A
				case "sltu" => 0x2B
			}
			instruction = instruction | (parameterIntValue1 << 11)
			instruction = instruction | (parameterIntValue2 << 21)
			instruction = instruction | (parameterIntValue3 << 16)
			output_instruction(instruction)

		case unexpected =>
			Console.err.println("ERROR PC=" + PC + ": Invalid parameters passed to " + parameterType + ", expecting (REG,REG,REG) but found: " + unexpected)
  	}
  }

  def output_type_jr(parameterKind: String, parameterValue: String, parameterType: String) : Unit = {
  	parameterKind match {
  		case "REG" => 
  			var parameterIntValue = java.lang.Integer.parseUnsignedInt(parameterValue.substring(1)) 
			var instruction : Long = if (parameterType == "jr") 0x8 else 0x9
			instruction = instruction | (parameterIntValue << 21)
			output_instruction(instruction)
  		
	  	case unexpected => 
	  		Console.err.println("ERROR PC=" + PC + ": Invalid Kind of parameter passed to " + parameterType + ", expecting REG(0-31) but found: " + parameterKind + " with value: " + parameterValue)
  	}
  }


  def output_type_word(parameterKind: String, parameterValue: String) : Unit = {
  	parameterKind  match {
  		case "ID" => 
  			var parameterIntValue = table.getOrElse(parameterValue, -1)
	        if (parameterIntValue == -1) {
	          Console.err.println("ERROR PC=" + PC + ": Invalid LABEL-ID(" + parameterValue + ") passed to .word (LABEL not defined)")
	        }
	        else {
	          output_instruction(parameterIntValue.toLong) 
	        }
  		
  		case "HEXINT" => 
  			var parameterIntValue = java.lang.Integer.parseUnsignedInt(parameterValue.substring(2), 16)
        	output_instruction(parameterIntValue.toLong)
  		
	  	case "INT" => 
	  		output_instruction(parameterValue.toLong) 
	  	
	  	case unexpected => 
	  		Console.err.println("ERROR PC=" + PC + ": .word only accepts INT, HEXINT or LABEL but passed a " + parameterKind + " " + parameterValue) //wrong type of data passed to word
  	}
  }
    
  def output_instruction(instruction : Long): Unit = {
    var arr = new ArrayBuffer[Byte](32)
    arr += (((instruction >> 24)& 0xff).toChar).toByte
    arr += (((instruction >> 16)& 0xff).toChar).toByte
    arr += (((instruction >> 8)& 0xff).toChar).toByte
    arr += ((instruction & 0xff).toChar).toByte
    System.out.write(arr.toArray)
    PC += 4
  }

  def main(args: Array[String]): Unit = assemble()

  def pass1(): Unit = {  	
  	var valid : Boolean = true
  	var pc: Int = 0
    for (tokenLine <- tokenLines) {
      for (token <- tokenLine) {
      	if (token.kind != "LABEL") {
      		if (validInstructions.contains(token.lexeme.toLowerCase)) {
      			pc += 4
      		}
      		valid = false
      	}
        else {
          var labelname: String = token.lexeme.substring(0, token.lexeme.length-1)
        	if (valid == true) {
				var exists = table.getOrElse(labelname, -1)
				//Console.err.print("Saw label with lexeme " + token.lexeme.substring(0, token.lexeme.length-1));
				if (exists == -1) {
			        //Console.err.println(" and added it to dictionary with value "+ pc +"!")
			        table += (token.lexeme.substring(0, token.lexeme.length-1) -> pc)
				}
				else {
		            Console.err.println("ERROR PC=" + pc + ": " + labelname + " LABEL already defined")
		            //Console.err.println("ERROR PC=" + PC + ": ignored label " + token.lexeme.substring(0, token.lexeme.length-1))
				}
		    }        
			else {
       			Console.err.println("ERROR PC=" + pc + ": " + labelname + " LABEL not defined correctly (should be at the beginning of instruction)")
				//Console.err.print("Saw label with lexeme " + token.lexeme.substring(0, token.lexeme.length-1));
				//Console.err.println("ERROR PC=" + PC + ": ignored label " + token.lexeme.substring(0, token.lexeme.length-1) + " because already exists")
			}
        }
      }
      valid = true
    }
  }

  def output_symbol_table() : Unit = {
    for ((key, value) <- table) {
      Console.err.println(key + " " + value)
    }
  }
}
