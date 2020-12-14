import scala.annotation.tailrec

/***
  * CFGRL starter code for CS241 A7
  * Based on cfgrl.rkt by Gordon V. Cormack
  * Created by Sean Harrap for CS241 in Winter 2017.
  */
object CFGRL {
  case class ParseTree(tok: String, children: Seq[ParseTree]) {
    //Performs a preorder traversal of a parse tree, where the integer
    //associated with each tree is its level of indentation.
    //The list "s" is a stack.
    def preorder(): Unit = {
      var s: List[(ParseTree,Int)] = List((this,0))
      while (s.nonEmpty) {
        val (p,depth) = s.head
        s = p.children.toList.map((_,1+depth)) ++ s.tail
        println(" " * depth + p.tok)
      }
    }
  }
  def main(args: Array[String]): Unit = {
    val input = io.Source.stdin.getLines()
    val numTerminals: Int = input.next().toInt
    println(numTerminals)
    (1 to numTerminals).foreach(_ => println(input.next()))   // Print terminals
    val numNonterminals: Int = input.next().toInt
    println(numNonterminals)
    val nonterminals: Set[String] = (1 to numNonterminals).map(_ => input.next()).toSet
    nonterminals.foreach(println)
    val startSymbol = input.next()
    println(startSymbol)
    val numProductions: Int = input.next().toInt
    println(numProductions)
    (1 to numProductions).foreach(_ => println(input.next())) // Print productions

    //Reads a tree recursively from stdin
    @tailrec def readTree(stack: List[ParseTree]): ParseTree = {
      val ln = input.next()
      val lnProd = ln.split(' ')
      val times = lnProd.tail.count(nonterminals.contains) //Number of children at this node
      if (lnProd.head == startSymbol) ParseTree(ln,Seq(stack.head))
      else readTree(ParseTree(ln,stack.take(times).reverse) :: stack.drop(times))
    }

    //Read the tree and print its preorder traversal
    while (input.hasNext) readTree(Nil).preorder()
  }
}
