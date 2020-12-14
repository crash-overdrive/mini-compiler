import scala.io.StdIn.{readLine, readInt}
import scala.collection.mutable.ListBuffer
import scala.collection.mutable.Map

object WLP4Gen {

    class FunctionInfo(var name: String, var signature: String, var symbol_table: SymbolTable) {
        def print_info() : Unit = {
            Console.err.println(name + " " + signature)
            output_symbol_table(symbol_table)
            
            Console.err.println()
        }
        def get_type(variable_id: String) : String = {
            var variable_type = symbol_table.getOrElse(variable_id, "NOT_FOUND")
            return variable_type
        }
    }

    class Tree(var value:String, var rule: String, var tokens: List[String], var children: ListBuffer[Tree]) {
        def addChild(child: Tree) : Unit = {
            children += child
        }    
        

        def insertChild(parent_noofchildren: Int): Unit = {
            
            if (parent_noofchildren == 0) {
                return
            }
            else {
                
                var current_input : String  = getNextInput()
                var current_input_list : List[String] = current_input.split(" ").toList
                var child_value: String = current_input_list(0)
                var child_rule: String = current_input
                var child_tokens: List[String] = current_input_list
                var child_noofchildren: Int = current_input_list.length - 1
                var child_children: ListBuffer[Tree] = new ListBuffer[Tree]

                if (Terminals.contains(child_value)) {
                    child_noofchildren = 0
                }

                var newchild: Tree = new Tree(child_value, child_rule, child_tokens, child_children)

                addChild(newchild)

                children(children.length-1).insertChild(child_noofchildren)

                insertChild(parent_noofchildren - 1)
            }
        }


        def postorder(): Unit = {
            if (children.length==0) {
                println(value + " " + 0 + " " + rule)
            }
            else {
                for (i <- children) {
                    i.postorder
                }
                println(value + " " + children.length + " " + rule)
            }
        }
    }

    type SymbolTable = Map[String, String]
    //type GlobalSymbolTable = ListBuffer[String, ListBuffer[String], SymbolTable]

    val full_input = io.Source.stdin.getLines()

    val Terminals: List[String] = List("BOF", "BECOMES", "COMMA", "ELSE", "EOF", "EQ", "GE", "GT", "ID", "IF", "INT", "LBRACE", "LE", "LPAREN", "LT", "MINUS", "NE", "NUM", "PCT", 
                                    "PLUS", "PRINTLN", "RBRACE", "RETURN", "RPAREN", "SEMI", "SLASH", "STAR", "WAIN", "WHILE", "AMP", "LBRACK", "RBRACK", "NEW", "DELETE", "NULL")

    
    //var global_symbol_table : SymbolTable = new ListBuffer[String, new ListBuffer[String],]
    def getNextInput() : String = {
        var current_input: String = " "
        if (full_input.hasNext) {
            current_input = full_input.next()
        }
        else {
            Console.err.println("Ran out of inputs.... Shit")
            
        }
        return current_input
    }

    def inOrderCreate() : Tree = {
        var current_input : String  = getNextInput()
        var current_input_list : List[String] = current_input.split(" ").toList
        var parent_value: String = current_input_list(0)
        var parent_rule: String = current_input
        var parent_tokens: List[String] = current_input_list
        var parent_noofchildren: Int = current_input_list.length - 1
        var parent_children: ListBuffer[Tree] = new ListBuffer[Tree]

        if (Terminals.contains(parent_value)) {
            parent_noofchildren = 0
        }

        var finaltree : Tree = new Tree(parent_value, parent_rule, parent_tokens, parent_children)

        finaltree.insertChild(parent_noofchildren)
        //finaltree.postorder

        return finaltree
    }

    

    def output_symbol_table(symbol_table: SymbolTable) : Unit = {
        //Console.err.println("wain")
        for ((key, value) <- symbol_table) {
          Console.err.println(key + " " + value)
        }
        
    }

    def getSymbolTable(ParseTree: Tree, symbol_table: SymbolTable) : Unit = {
        var parse_tree = ParseTree
        
        for (child <- parse_tree.children) {
            
            if (!(Terminals.contains(child.value))) {
                if (child.rule == "dcl type ID") {
                    var variable_id : String = child.children(1).tokens(1)
                    var variable_type : String = " "
                    if (child.children(0).tokens.length == 3) {
                        variable_type = "int*"
                    }
                    else if (child.children(0).tokens.length == 2) {
                        variable_type = "int"
                    }
                    else {
                        variable_type = "NOT POSSIBLE"
                    }
                    //println ("Decleration found!! type: " + variable_type + ", id: " + variable_id)
                    var exists = symbol_table.getOrElse(variable_id, -1)
                    if (exists == -1) {
                        symbol_table += (variable_id -> variable_type)
                    }
                    else {
                        Console.err.println("ERROR : Variable " + variable_id + " already defined!!")
                    }
                }
                getSymbolTable(child, symbol_table)
            }
        }            
    }

    def checkVariableUse(ParseTree: Tree, symbol_table: SymbolTable, global_symbol_table: ListBuffer[FunctionInfo]) : Unit = {
        var parse_tree = ParseTree
        for (child <- parse_tree.children) {
            if (!(Terminals.contains(child.value))) {
                if (child.rule == "factor ID" || child.rule == "lvalue ID") {
                    var variable_id = child.children(0).tokens(1)
                    //println("Use of variable found!! Variable id: " + variable_id)
                    var exists = symbol_table.getOrElse(variable_id, -1)
                    if (exists == -1) {
                        Console.err.println("ERROR : Variable " + variable_id + " used but not defined!!")
                    }
                }
                else if(child.rule == "factor ID LPAREN RPAREN" || child.rule == "factor ID LPAREN arglist RPAREN") {
                    var function_invoked_name = child.children(0).tokens(1)
                    if (function_invoked_name == "wain") {
                        Console.err.println("ERROR : Cannot Invoke wain function!!")
                    }
                    else if (!(function_defined(global_symbol_table, function_invoked_name))) {
                        Console.err.println("ERROR : Cannot Invoke function" + function_invoked_name + " as it has not been defined yet!!")
                    }

                    var overshadowing = symbol_table.getOrElse(function_invoked_name, -1)
                    //println("overshadowing result: " + overshadowing)
                    if(overshadowing != -1) {
                        Console.err.println("ERROR : Cannot Invoke function " + function_invoked_name + " because it refers to the local variable by same name!!")
                    }

                }
                checkVariableUse(child, symbol_table, global_symbol_table)
            }
        }
    }
    
    def get_function_signature(paramlistNode: Tree) : String = {
        var function_signature: String = ""
        var no_of_children_type : Int = paramlistNode.children(0).children(0).children.length
        if (no_of_children_type == 2) {
            function_signature = "int* "
        }
        else if (no_of_children_type == 1) {
            function_signature = "int "
        }
        else {
            function_signature = "NOT_POSSIBLE "
        }
        if (paramlistNode.children.length == 1) {
            return function_signature
        }
        else {
            function_signature += get_function_signature(paramlistNode.children(2))
        }
        return function_signature
    }

    def get_main_signature(mainNode: Tree) : String = {
        var function_signature: String = ""
        var no_of_children_type1 : Int = mainNode.children(3).children(0).children.length
        var no_of_children_type2 : Int = mainNode.children(5).children(0).children.length
        if (no_of_children_type1 == 2) {
            function_signature = "int* "
        }
        else if (no_of_children_type1 == 1) {
            function_signature = "int "
        }
        else {
            function_signature = "NOT_POSSIBLE "
        }
        if (no_of_children_type2 == 2) {
            function_signature += "int* "
        }
        else if (no_of_children_type2 == 1) {
            function_signature += "int "
        }
        else {
            function_signature += "NOT_POSSIBLE "
        }
        return function_signature
    }

    def function_defined(global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : Boolean = {
        for (function_info <- global_symbol_table) {
            if (function_info.name == function_name) {
                return true
            }
        }
        return false
    }

    def variable_type(global_symbol_table: ListBuffer[FunctionInfo], function_name: String, variable_id: String) : String = {
        var var_type : String = ""
        for (function_info <- global_symbol_table) {
            if (function_info.name == function_name) {
                var_type = function_info.get_type(variable_id)
            }
        }
        return var_type
    }

    def context_sensitive_analysis(ParseTree: Tree) : ListBuffer[FunctionInfo] = {
        var global_symbol_table: ListBuffer[FunctionInfo] = ListBuffer()
        var procedureS_root: Tree = ParseTree.children(1)
        var procedure_root : Tree = procedureS_root.children(0)
        var function_name : String = procedure_root.children(1).tokens(1)
        while (function_name != "wain") {   
            //println("Rule at current Node for function name" + function_name + " is: " + procedure_root.rule)
            //println(function_name)       
            if (function_defined(global_symbol_table, function_name)) {
                Console.err.println("ERROR : Function with name " + function_name + " already defined!!")
            }
            else {
                //println(procedure_root.children(3).value)
                var function_signature: String = ""
                if (procedure_root.children(3).children.length != 0) {
                    function_signature = get_function_signature(procedure_root.children(3).children(0))
                }
                
                var symbol_table : SymbolTable = Map[String, String]()
                getSymbolTable(procedure_root, symbol_table)
                var function_info: FunctionInfo = new FunctionInfo(function_name, function_signature, symbol_table)
                global_symbol_table += function_info
                checkVariableUse(procedure_root, symbol_table, global_symbol_table)
                
            }
            procedureS_root = procedureS_root.children(1)
            procedure_root = procedureS_root.children(0)
            function_name = procedure_root.children(1).tokens(1)
        }
        if (function_name == "wain") {
            //println("Rule at current Node for function name" + function_name + " is: " + procedure_root.rule)
            var function_signature: String = get_main_signature(procedure_root)
            var symbol_table : SymbolTable = Map[String, String]()
            getSymbolTable(procedure_root, symbol_table)
            var function_info: FunctionInfo = new FunctionInfo(function_name, function_signature, symbol_table)
            global_symbol_table += function_info
            checkVariableUse(procedure_root, symbol_table, global_symbol_table)
            
            //output_symbol_table(symbol_table)
            
        } 
        return global_symbol_table
    
    }


    def type_of(ParseTree: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : String = {
        var children: ListBuffer[Tree] = ParseTree.children
        var self_type: String = "UNINITIALISED_RULE"
        var child1_type: String = ""
        var child2_type: String = ""
        /*for (child <- children) {
            var types : String = type_of(child)
        }*/
        var current_rule : String = ParseTree.rule
        var current_tokens : List[String] = ParseTree.tokens
        
        current_rule match {
            case "factor ID" | "lvalue ID" =>
                var variable_id = ParseTree.children(0).tokens(1)
                self_type = variable_type(global_symbol_table, function_name, variable_id)

            case "factor NUM" =>
                self_type = "int"

            case "factor NULL" =>
                self_type = "int*"

            case "factor LPAREN expr RPAREN" =>
                self_type = type_of(ParseTree.children(1), global_symbol_table, function_name)

            case "expr term" | "term factor" =>
                self_type = type_of(ParseTree.children(0), global_symbol_table, function_name)

            case "factor AMP lvalue" =>
                child1_type = type_of(ParseTree.children(1), global_symbol_table, function_name)
                if (child1_type == "int") {
                    self_type = "int*"
                }
                else {
                    self_type = "ERROR"
                }

            case "factor STAR factor" =>
                child1_type = type_of(ParseTree.children(1), global_symbol_table, function_name)
                if (child1_type == "int*") {
                    self_type = "int"
                }
                else {
                    self_type = "ERROR"
                }

            case "factor NEW INT LBRACK expr RBRACK" =>
                child1_type = type_of(ParseTree.children(3), global_symbol_table, function_name)
                if (child1_type == "int") {
                    self_type = "int*"
                }
                else {
                    self_type = "ERROR"
                }

            case "term term STAR factor" | "term term SLASH factor" | "term term PCT factor" => {
                child1_type = type_of(ParseTree.children(0), global_symbol_table, function_name)
                child2_type = type_of(ParseTree.children(2), global_symbol_table, function_name)
                if (child1_type == "int" && child2_type == "int") {
                    self_type = "int"
                }
                else {
                    self_type = "ERROR"
                }
            }
            case "expr expr PLUS term" =>
                child1_type = type_of(ParseTree.children(0), global_symbol_table, function_name)
                child2_type = type_of(ParseTree.children(2), global_symbol_table, function_name)
                if (child1_type == "int" && child2_type == "int") {
                    self_type = "int"
                }
                else if (child1_type == "int*" && child2_type == "int") {
                    self_type = "int*"
                }
                else if (child1_type == "int" && child2_type == "int*") {
                    self_type = "int*"
                }
                else {
                    self_type = "ERROR"
                }
            case "expr expr MINUS term" =>
                child1_type = type_of(ParseTree.children(0), global_symbol_table, function_name)
                child2_type = type_of(ParseTree.children(2), global_symbol_table, function_name)
                if (child1_type == "int" && child2_type == "int") {
                    self_type = "int"
                }
                else if (child1_type == "int*" && child2_type == "int") {
                    self_type = "int*"
                }
                else if (child1_type == "int*" && child2_type == "int*") {
                    self_type = "int"
                }
                else {
                    self_type = "ERROR"
                }
            case "factor ID LPAREN RPAREN" => 
                self_type = "int"

            case "factor ID LPAREN arglist RPAREN" =>
                self_type = "int"

            case "lvalue STAR factor" =>
                child1_type = type_of(ParseTree.children(1), global_symbol_table, function_name)
                if (child1_type == "int*") {
                    self_type = "int"
                }
                else {
                    self_type = "ERROR"
                }

            case "lvalue LPAREN lvalue RPAREN" =>
                self_type = type_of(ParseTree.children(1), global_symbol_table, function_name)

            case unexpected_rule => 
                println("Unexpected rule encountered!! Rule: " + unexpected_rule)
                self_type = "ERROR"
        } 
        println(self_type)
        return self_type
    }

    def type_check_statement(statementS_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : Unit = {
        var statementS_node_length = statementS_node.children.length
        if (statementS_node_length != 0) {
            var statement_node : Tree = statementS_node.children(0)
            var statement_node_children : ListBuffer[Tree] = statement_node.children
            for (child <- statement_node_children) {
                if (child.value == "lvalue" || child.value == "expr") {
                    var types : String = type_of(child, global_symbol_table, function_name)
                    if (types == "ERROR") {
                        Console.err.println("ERROR")
                    }
                }
                else if (child.value == "statements") {
                    type_check_statement(child, global_symbol_table, function_name)
                }
            }

        }
        return 
    }

    def type_check_procedures(ParseTree: Tree, global_symbol_table: ListBuffer[FunctionInfo]): Unit = {
        var procedureS_root: Tree = ParseTree.children(1)
        var procedure_root : Tree = procedureS_root.children(0)
        var function_name : String = procedure_root.children(1).tokens(1)
        while (function_name != "wain") {
            var statementS_node = procedure_root.children(7)
            type_check_statement(statementS_node, global_symbol_table, function_name)
            procedureS_root = procedureS_root.children(1)
            procedure_root = procedureS_root.children(0)
            function_name = procedure_root.children(1).tokens(1)
        }
        if (function_name == "wain") {
            var statementS_node = procedure_root.children(9)
            type_check_statement(statementS_node, global_symbol_table, function_name)
        }
    }

    def main (args: Array[String]) : Unit = {       
        var ParseTree: Tree = inOrderCreate()
        //println(ParseTree.children(1).rule)
        var global_symbol_table: ListBuffer[FunctionInfo] = context_sensitive_analysis(ParseTree)
        type_check_procedures(ParseTree, global_symbol_table)
        /*for (function_info <- global_symbol_table) {
            function_info.print_info
        }*/
       // if (global_symbol_table)
       // Console.err.println("ERROR")

    }
    
}



