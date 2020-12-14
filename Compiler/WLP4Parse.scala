import scala.annotation.tailrec
import scala.collection.mutable.ListBuffer
import scala.collection.mutable.Stack
import scala.io.StdIn.{readLine, readInt}
import scala.io.Source

object WLP4Parse {

  val bufferedSource = Source.fromFile("wlp4grammar.lr1")
  var fileInput = bufferedSource.getLines()
  var StdInput = io.Source.stdin.getLines()
  //println(StdInput)
  
  var numTerminal: Int = fileInput.next().toInt
  var terminalSet: Set[String] = (1 to numTerminal).map(_ => fileInput.next()).toSet
  var numNonterminal: Int = fileInput.next().toInt
  var nonterminalSet: Set[String] = (1 to numNonterminal).map(_ => fileInput.next()).toSet 
  var startSymbol: String = fileInput.next()
  var numProductions: Int = fileInput.next().toInt
  var productionRules:ListBuffer[String] = ListBuffer()
  (1 to numProductions).map(_ => productionRules += fileInput.next())
  var numStatesParser:Int = fileInput.next().toInt
  var numTransitionsParser: Int = fileInput.next().toInt
  var Transitions: Array[ListBuffer[Transition]]  = new Array[ListBuffer[Transition]](numStatesParser)
  
  case  class Transition(currentState: Int, input: String, action: String, nextState: Int) {
    def printer():Unit = {
      println(currentState + " " + input + " " + action + " " + nextState)
    }
  }

  class Tree(var rule: String, var children: ListBuffer[Tree]) {
    def printer(): Unit = {
      println(rule)
      if (children.length == 0) {
        return
      }
      else {
       for (i <- children) {
        i.printer
        }
      }
    }
  }

  def print_readin() : Unit = {
      
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
    
  }

  def do_action(transition_initial_state: Int, transition_input: String): String = {

    if (transition_initial_state >= 0 && transition_initial_state < numStatesParser) {
      var possible_transitions : ListBuffer[Transition] = Transitions(transition_initial_state)
      for (possible_transition <- possible_transitions) {
        if (possible_transition.input == transition_input) {

          if (possible_transition.action == "reduce") {

            return(possible_transition.action + " " + productionRules(possible_transition.nextState))

          }

          else {

            return(possible_transition.action + " " + possible_transition.nextState)

          }
        }
      }
    }
    return "error"
  }
  

  def get_derivation_tree() : Tree = {

    
    //var procedures_tree: Tree = new Tree("", ListBuffer())
    var tree_stack : ListBuffer[Tree] = ListBuffer()
    var popped_tree_stack : ListBuffer[Tree] = ListBuffer()
    
    var state_stack: Stack[Int] = new Stack[Int]
    var symbol_stack: Stack[String] = new Stack[String]  
  
    var current_input: ListBuffer[String] = new ListBuffer[String]
    StdInput.copyToBuffer(current_input)
    current_input = current_input ++ ListBuffer("EOF EOF")
    var temp_input: String = "BOF BOF"
    var currentInputToken : String = "BOF"
    var currentInputLexeme: String = "BOF"

    var InputLength : Int = current_input.length - 1

    var derivation : ListBuffer[String] = new ListBuffer[String] // stores all derivations, useless for parser

    state_stack.push(0)
    symbol_stack.push(currentInputToken)

    var action_result: String = do_action(state_stack.top, symbol_stack.top)
    var action_result_list : Array[String] = action_result.split(" ")
    var action_prefix : String = action_result_list(0)

    if (action_prefix == "shift") {
      state_stack.push(action_result_list(1).toInt)
      tree_stack += new Tree(temp_input, ListBuffer())
      //Console.err.println("Pushed " + temp_input + " on tree_stack, length = " + tree_stack.length)
    }
    else {
      Console.err.println("ERROR at " + 1)
      Console.err.println("ERROR: Fatal Error, saw " + action_prefix + " while expecting Shift when pushing initialising state_stack")
      Console.err.println("Transition seen: " + action_prefix)
      System.exit(0)
    }
    
    for (i <- 0 to InputLength) {
      
      temp_input = current_input(i)
      currentInputToken = temp_input.split(" ")(0)
      currentInputLexeme = temp_input.split(" ")(1)      
      
      action_result = do_action(state_stack.top, currentInputToken)
      //Console.err.println(action_result)
      action_result_list = action_result.split(" ")
      action_prefix = action_result_list(0)

      while(action_prefix == "reduce") {
        var part_derivation : String = action_result_list(1)
        for (count <- 2 to action_result_list.length - 1) {
          part_derivation += " " + action_result_list(count)
        }
        derivation += part_derivation
        //procedures_tree = new Tree(part_derivation, procedures_tree)
        var no_of_pops : Int = action_result_list.length - 2
        //Console.err.println("No of pops: " + no_of_pops)
        //Console.err.println("Stack's before reducing")
        //Console.err.println(state_stack)
        //Console.err.println(symbol_stack)
        for (count <- 1 to no_of_pops) {
          state_stack.pop 
          symbol_stack.pop         
          popped_tree_stack = ListBuffer(tree_stack(tree_stack.length - 1)) ++ popped_tree_stack
          //Console.err.println("Popped " + tree_stack(tree_stack.length - 1).rule + " from tree_stack")
          tree_stack = tree_stack.slice(0, tree_stack.length - 1)
          //Console.err.println("Tree stack length: " + tree_stack.length)
        } 

        //Console.err.println("Stack's after popping")
        //Console.err.println(state_stack)
        //Console.err.println(symbol_stack)

        symbol_stack.push(action_result_list(1))

        //Console.err.println("Stack's after pushing back on symbol stack")
        //Console.err.println(state_stack)
        //Console.err.println(symbol_stack)

        action_result = do_action(state_stack.top, symbol_stack.top)
        action_result_list = action_result.split(" ")
        action_prefix = action_result_list(0)
        
        if (action_prefix == "shift") {
          state_stack.push(action_result_list(1).toInt)
          
          tree_stack += new Tree(part_derivation, popped_tree_stack)
          //Console.err.println("Pushed " + part_derivation + " on tree_stack, length = " + tree_stack.length)
          popped_tree_stack = ListBuffer()
          //Console.err.println("Stack's after pushing back on state stack")
          //Console.err.println(state_stack)
          //Console.err.println(symbol_stack)
        }
        else {
          Console.err.println("ERROR at " + (i+1))
          Console.err.println("Fatal Error, saw " + action_prefix + " while expecting Shift when pushing a terminal onto symbol_stack(after reducing ofcourse)")
          Console.err.println("Transition seen: " + action_prefix)
          System.exit(0)
        }
        
        action_result = do_action(state_stack.top, currentInputToken)
        //Console.err.println(action_result)
        action_result_list = action_result.split(" ")
        action_prefix = action_result_list(0)

      }

      symbol_stack.push(currentInputToken)

      action_result = do_action(state_stack.top, symbol_stack.top)
      action_result_list = action_result.split(" ")
      action_prefix = action_result_list(0)

      if (action_prefix == "shift") {
        state_stack.push(action_result_list(1).toInt)
        tree_stack += new Tree(temp_input, ListBuffer())
        //Console.err.println("Pushed " + temp_input + " on tree_stack, length = " + tree_stack.length)
      }

      else {
        Console.err.println("ERROR at " + (i+1))
        Console.err.println("No transition out of state for input " + currentInputToken + " at position " + (i+1))
        Console.err.println("Transition seen: " + action_prefix)
        //Console.err.println(action_result)
        //Console.err.println(state_stack)
        //Console.err.println(symbol_stack)
        System.exit(0)
      }

    }
    //Console.err.println("Symbol stack top after parsing: " + symbol_stack.top)
    if (symbol_stack.top == "EOF") {
      Console.err.println("Parsing completed successfully!")
    }
    else {
      Console.err.println("Parsing Error")
    }
    derivation += productionRules(0)

    var parse_tree: Tree = new Tree("start BOF procedures EOF", tree_stack)

    return parse_tree
  }


  def main(args: Array[String]): Unit = { 

    

    //initialising each element of ListBuffer Transitions to be an empty ListBuffer
    for(x <- 1 to numStatesParser) {
      Transitions(x-1) = ListBuffer()
    }

    //adding each Transition in the correct element(ListBuffer) of Transitions
    for(x <- 1 to numTransitionsParser) {
      var inputTransition = fileInput.next().split(" ")
      Transitions(inputTransition(0).toInt) += new Transition(inputTransition(0).toInt, inputTransition(1), inputTransition(2), inputTransition(3).toInt)
    }

    //print_readin()  //printing all read in stuff 

    var derivation_tree: Tree = get_derivation_tree()
    derivation_tree.printer()
    bufferedSource.close
    
  }
}

