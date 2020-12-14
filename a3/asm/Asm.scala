import Scanning._
import scala.io.StdIn.{readLine, readInt}
import scala.collection.mutable.ArrayBuffer
object Asm {
  /* A sequence of sequences of tokens, where each inside sequence represents a line.
   * For example, tokenLines(3)(4) is the fifth token on line 4.
   */
  val tokenLines: Seq[Seq[Token]] = io.Source.stdin.getLines.map(scan).toSeq
  var instructions: List[String] = List("WORD", "ADD")
  var validTokenLines : Seq[Seq[Token]] = tokenLines

  type SymbolTable = Map[String, Int]
  var pc: Int = 0
  var table : SymbolTable = Map[String, Int]()

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
        if (tokenLine(i).kind != "LABEL") //if ends with label then line isnt relevant here anyway
        {
          if (tokenLine(i).kind == "WORD"){
            //can still be valid or invalid
            if (linelength == i + 2) { 
              //Console.err.println("Saw .word with " + tokenLine(i+1).kind + " kind and " + tokenLine(i+1).lexeme + " value")
              output_word(tokenLine(i + 1).kind, tokenLine(i + 1).lexeme)          
            }
            else { // too many or none at all variables passed to .word
              Console.err.println("ERROR : .word only takes one input but passed " + (linelength - i - 1) + " input(s)")
            }
          }
          else { //first kind not a word
            Console.err.println("ERROR : invalid start of instruction")
          }
        }
      } 
    }
    output_symbol_table()
  }
  
  def pass1(): Unit = {
  	var valid : Boolean = true
    for (tokenLine <- tokenLines) {
      for (tk <- tokenLine) {
      	if (tk.kind != "LABEL") {
      		if (instructions.contains(tk.kind)) {
      			pc += 4
      		}
      		valid = false
      	}
        else {
          var labelname: String = tk.lexeme.substring(0, tk.lexeme.length-1)
        	if (valid == true) {
				var exists = table.getOrElse(labelname, -1)
				//Console.err.print("Saw label with lexeme " + tk.lexeme.substring(0, tk.lexeme.length-1));
				if (exists == -1) {
			        //Console.err.println(" and added it to dictionary with value "+ pc +"!")
			        table += (tk.lexeme.substring(0, tk.lexeme.length-1) -> pc)
				}
				else {
		            Console.err.println("ERROR : " + labelname + " LABEL already defined")
		            //Console.err.println("ERROR: ignored label " + tk.lexeme.substring(0, tk.lexeme.length-1))
				}
		    }        
			else {
       			Console.err.println("ERROR : " + labelname + " LABEL not defined correctly")
				//Console.err.print("Saw label with lexeme " + tk.lexeme.substring(0, tk.lexeme.length-1));
				//Console.err.println("ERROR: ignored label " + tk.lexeme.substring(0, tk.lexeme.length-1) + " because already exists")
			}
        }
      }
      valid = true
    }
  }
  def label_filter(tk: Token) : Boolean = {
  	if (tk.kind != "LABEL")
  		return true
  	else
  		return false
  }
  def clean_tokenLines() : Unit = {
  	for (tokenLine <- tokenLines) {
  		var filteredTokenLine = tokenLine.filter(label_filter)
  		if (filteredTokenLine.length != 0) {
  			Console.err.println("Added a tokenLine of length " + filteredTokenLine.length)
  			Console.err.println(filteredTokenLine)
  			//validTokenLines += filteredTokenLine
  		}  		
  	}
  }

  def output_symbol_table() : Unit = {
    for ((key, value) <- table) {
      Console.err.println(key + " " + value)
    }
  }

  def output_word(wordkind: String,wordvalue: String) : Unit = {
    if(wordkind == "INT" || wordkind == "HEXINT" || wordkind == "ID") {
      if (wordkind == "ID") {
        var wordintvalue = table.getOrElse(wordvalue, -1)
        if (wordintvalue == -1) {
          Console.err.println("ERROR : Invalid ID passed to .word (ID not defined)")
        }
        else {
          output_instruction(wordintvalue.toLong) 
        }
      }
      else if (wordkind == "HEXINT") {
        var wordintvalue = java.lang.Integer.parseUnsignedInt(wordvalue.substring(2),16)
        output_instruction(wordintvalue.toLong) 
      }
      else {
        output_instruction(wordvalue.toLong)  
      }
    }
    else {
      Console.err.println("ERROR : .word only accepts INT, HEXINT or LABEL") //wrong type of data passed to word
    }
  }


  def output_instruction(tk2value: Long): Unit = {
    var arr = new ArrayBuffer[Byte](32)
    arr += (((tk2value >> 24)& 0xff).toChar).toByte
    arr += (((tk2value >> 16)& 0xff).toChar).toByte
    arr += (((tk2value >> 8)& 0xff).toChar).toByte
    arr += ((tk2value & 0xff).toChar).toByte
    System.out.write(arr.toArray)
  }

  def main(args: Array[String]): Unit = assemble()
}
