import scala.annotation.tailrec
import scala.collection.mutable.ListBuffer

object LR {

  case  class Transition(currentState: Int, input: String, action: String, nextState: Int) {
    def printer():Unit = {
      println(currentState + " " + input + " " + action + " " + nextState)
    }
  }


  def main(args: Array[String]): Unit = {

    val input = io.Source.stdin.getLines()

    val numTerminal: Int = input.next().toInt

    val terminalSet : Set[String] = (1 to numTerminal).map(_ => input.next()).toSet    

    val numNonterminal: Int = input.next().toInt
    
    val nonterminalSet: Set[String] = (1 to numNonterminal).map(_ => input.next()).toSet    

    val startSymbol = input.next()    

    val numProductions: Int = input.next().toInt
    
    val productionRules: ListBuffer[String] = ListBuffer()
    (1 to numProductions).map(_ => productionRules += input.next())

    val numStatesParser : Int = input.next().toInt

    val numTransitionsParser : Int = input.next().toInt

    val Transitions : Array[ListBuffer[Transition]] = new Array[ListBuffer[Transition]](numStatesParser)

    for(x <- 1 to numStatesParser) {
      Transitions(x-1) = ListBuffer()
    }

    for(x <- 1 to numTransitionsParser) {
      var inputTransition = input.next().split(" ")
      Transitions(inputTransition(0).toInt) += new Transition(inputTransition(0).toInt, inputTransition(1), inputTransition(2), inputTransition(3).toInt)
    }

    //printing all read in stuff
    
    println(numTerminal)
    terminalSet.foreach(println)   
    println(numNonterminal) 
    nonterminalSet.foreach(println)
    println(startSymbol)
    println(numProductions)
    productionRules.zipWithIndex.foreach{ case(rule, index) => println(index + " " + rule) }
    println(numStatesParser)
    println(numTransitionsParser)
    for (transitionlist <- Transitions) {
      for (transition <- transitionlist) {
        transition.printer()
      }
    }
    
    //end of all read in stuff



    while (input.hasNext) {
      var flag = false
      var current_transition2 = input.next()
      //print (current_transition2 + " ")
      var current_transition = current_transition2.split(" ")
      var transition_initial_state : Int = current_transition(0).toInt
      var transition_input : String = current_transition(1)

      if (transition_initial_state >= 0 && transition_initial_state < numStatesParser) {
        var possible_transitions : ListBuffer[Transition] = Transitions(transition_initial_state)
        for (possible_transition <- possible_transitions) {
          if (possible_transition.input == transition_input) {
            flag = true
            if (possible_transition.action == "reduce") {
              println(possible_transition.action + " " + productionRules(possible_transition.nextState))
            }
            else {
              println(possible_transition.action + " " + possible_transition.nextState)
            }
          }
        }
        if (flag == false) {
          println ("error")
        }
      }
      else {
        println ("error")
      }
      

    }
  }
}

