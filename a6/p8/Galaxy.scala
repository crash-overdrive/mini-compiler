import scala.io.Source
import scala.collection.mutable.ListBuffer


/**
 * A simple class to read a .cfg file and print the left-canonical
 * derivation without leading or trailing spaces.
 *
 * A scala translation od DerivationPrinter.java
 *
 * @version 071024.0
 */
object DerivationPrinter {
 
   def main(args: Array[String]) {
     val in = Source.fromInputStream(System.in).getLines
     skipGrammar(in)
     printDerivation(in)
  }


  /**
   * Skip the grammar part of the input.
   *
   * @param in the Iterator over lines read in
   */
  def skipGrammar(in: Iterator[String])= {
    assert(in.hasNext)

    // read the number of terminals and move to the next line
    val numTerm = in.next.replace('\n',' ').trim.toInt

    // skip the lines containing the terminals
    for (i <- 1 to numTerm) in.next
    
    // read the number of non-terminals and move to the next line
    val numNonTerm = in.next.replace('\n',' ').trim.toInt

    // skip the lines containing the non-terminals
    for (i <- 1 to numNonTerm) in.next

    // skip the line containing the start symbol
    in.next

    // read the number of rules and move to the next line
    val numRules = in.next.replace('\n',' ').trim.toInt

    // skip the lines containing the production rules
    for (i <- 1 to numRules) in.next
  }

  /**
   * Prints the derivation with whitespace trimmed.
   *
   * @param in the scanner for reading input
   */
  def printDerivation(in : Iterator[String]) = {
    var parsed : String = ""
    var input : String = ""
    var current : String = ""
    while (in.hasNext) {
      current = in.next.replace('\n',' ').trim + " "
      var nonterminal = current.split(" ")(0)
    
      println(current)
      println(nonterminal)
      //input = input + current
    }
    println(input)
  }
}

