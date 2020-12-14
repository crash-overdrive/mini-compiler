import scala.io.StdIn.{readLine, readInt}
import scala.collection.mutable.ListBuffer
import scala.collection.mutable.Map

object WLP4Gen {

    class VariableInfo(var var_type: String, var location: Int) {

    }

    class FunctionInfo(var name: String, var signature: String, var symbol_table: SymbolTable) {
        def print_info() : Unit = {
            Console.err.println(name + " " + signature)
            output_symbol_table(symbol_table)
            
            Console.err.println()
        }
        def get_type(variable_id: String) : String = {
            var variable_info : VariableInfo = symbol_table.getOrElse(variable_id, new VariableInfo("NOT_FOUND", 4))
            return variable_info.var_type
        }
        def get_location(variable_id: String) : Int = {
            //Console.err.println("Variable id passed is: " + variable_id)
            var variable_info : VariableInfo = symbol_table.getOrElse(variable_id, new VariableInfo("NOT_FOUND", 4))
            return variable_info.location
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

        def preorder() : Unit = {
            println(value + " " + children.length + " " + rule)
            if (children.length == 0) {
                return
            }
            else {
                 for (i <- children) {
                    i.preorder
                }

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

    type SymbolTable = Map[String, VariableInfo]
    var wain_first_paramter: String = ""
   
    val full_input = io.Source.stdin.getLines()

    var Var_Location: Int = 0
    var whilecount : Int = 1
    var ifcount : Int = 1
    var skipcount : Int = 1

    val Terminals: List[String] = List("BOF", "BECOMES", "COMMA", "ELSE", "EOF", "EQ", "GE", "GT", "ID", "IF", "INT", "LBRACE", "LE", "LPAREN", "LT", "MINUS", "NE", "NUM", "PCT", 
                                    "PLUS", "PRINTLN", "RBRACE", "RETURN", "RPAREN", "SEMI", "SLASH", "STAR", "WAIN", "WHILE", "AMP", "LBRACK", "RBRACK", "NEW", "DELETE", "NULL")

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
        //finaltree.preorder
        return finaltree
    }

    def output_symbol_table(symbol_table: SymbolTable) : Unit = {
        //Console.err.println("wain")
        for ((key, varinfo) <- symbol_table) {
          Console.err.println(key + " " + varinfo.var_type + " " + varinfo.location)
        }
        
    }

    def getSymbolTable(ParseTree: Tree, symbol_table: SymbolTable) : Unit = {
        
        var parse_tree = ParseTree
        
        for (child <- parse_tree.children) {
            
            if (!(Terminals.contains(child.value))) {
                if (child.rule == "dcl type ID") {
                    var variable_id : String = child.children(1).tokens(1)
                    var variable_type : String = get_type_from_node(child.children(0))
                    
                    var exists = symbol_table.getOrElse(variable_id, -1)
                    if (exists == -1) {
                        symbol_table += (variable_id -> new VariableInfo(variable_type, Var_Location))
                        Var_Location = Var_Location - 4
                    }
                    else {
                        Console.err.println("ERROR : Variable " + variable_id + " already defined!!")
                    }
                }
                getSymbolTable(child, symbol_table)
            }
        }            
    }

    def get_variable_location(global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String, variable_id: String) : Int = {
        for (function_info <- global_symbol_table) {
            if (procedure_name == function_info.name) {
                return function_info.get_location(variable_id)
            }
        }
        return 4
    }

    def checkVariableUse(ParseTree: Tree, symbol_table: SymbolTable, global_symbol_table: ListBuffer[FunctionInfo]) : Unit = {
        var parse_tree = ParseTree
        for (child <- parse_tree.children) {
            if (!(Terminals.contains(child.value))) {
                if (child.rule == "factor ID" || child.rule == "lvalue ID") {
                    var variable_id = child.children(0).tokens(1)
                    ////println("Use of variable found!! Variable id: " + variable_id)
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
                    ////println("overshadowing result: " + overshadowing)
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
        var type_node : Tree = paramlistNode.children(0).children(0)
       
        function_signature = get_type_from_node(type_node) + " "

        if (paramlistNode.children.length == 1) {
            return function_signature
        }
        else {
            function_signature += get_function_signature(paramlistNode.children(2))
        }
        return function_signature
    }

    def get_main_signature(mainNode: Tree) : String = {
        
        var type_node1 : Tree = mainNode.children(3).children(0)
        var type_node2 : Tree = mainNode.children(5).children(0)
        var function_signature: String = get_type_from_node(type_node1) + " " + get_type_from_node(type_node2)      
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
            if (function_defined(global_symbol_table, function_name)) {
                Console.err.println("ERROR : Function with name " + function_name + " already defined!!")
            }
            else {
                var function_signature: String = ""
                if (procedure_root.children(3).children.length != 0) {
                    function_signature = get_function_signature(procedure_root.children(3).children(0))
                }
                
                var symbol_table : SymbolTable = Map[String, VariableInfo]()
                Var_Location = 0
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
            var function_signature: String = get_main_signature(procedure_root)
            wain_first_paramter = function_signature.split(" ")(0)
            if (function_signature != "int* int" && function_signature != "int int") {
                Console.err.println("ERROR : function wain's parameter are either int* int or int int but got: " + function_signature)
                //println("ERROR : function wain's parameter are: int int but got: " + function_signature)
            }
            var symbol_table : SymbolTable = Map[String, VariableInfo]()
            Var_Location = 0
            getSymbolTable(procedure_root, symbol_table)
            var function_info: FunctionInfo = new FunctionInfo(function_name, function_signature, symbol_table)
            global_symbol_table += function_info
            checkVariableUse(procedure_root, symbol_table, global_symbol_table)            
        } 
        return global_symbol_table
    
    }


    def type_of(expr_lvalue_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : String = {
        var children: ListBuffer[Tree] = expr_lvalue_node.children
        var self_type: String = "UNINITIALISED_RULE"
        var child1_type: String = ""
        var child2_type: String = ""
        /*for (child <- children) {
            var types : String = type_of(child)
        }*/
        var current_rule : String = expr_lvalue_node.rule
        var current_tokens : List[String] = expr_lvalue_node.tokens
        
        current_rule match {
            case "factor ID" | "lvalue ID" =>
                var variable_id = expr_lvalue_node.children(0).tokens(1)
                self_type = variable_type(global_symbol_table, function_name, variable_id)
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "factor NUM" =>
                self_type = "int"
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "factor NULL" =>
                self_type = "int*"
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "factor LPAREN expr RPAREN" =>
                self_type = type_of(expr_lvalue_node.children(1), global_symbol_table, function_name)
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "expr term" | "term factor" =>
                self_type = type_of(expr_lvalue_node.children(0), global_symbol_table, function_name)
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "factor AMP lvalue" =>
                child1_type = type_of(expr_lvalue_node.children(1), global_symbol_table, function_name)
                if (child1_type == "int") {
                    self_type = "int*"
                }
                else {
                    self_type = "ERROR"
                }
                //println("called typeOf on rule: " + current_rule + ", lvalue(child) was of type: " + child1_type + ", Final type was " + self_type)

            case "factor STAR factor" =>
                child1_type = type_of(expr_lvalue_node.children(1), global_symbol_table, function_name)
                if (child1_type == "int*") {
                    self_type = "int"
                }
                else {
                    self_type = "ERROR"
                }
                //println("called typeOf on rule: " + current_rule + ", factor(child) was of type: " + child1_type + ", Final type was " + self_type)

            case "factor NEW INT LBRACK expr RBRACK" =>
                child1_type = type_of(expr_lvalue_node.children(3), global_symbol_table, function_name)
                if (child1_type == "int") {
                    self_type = "int*"
                }
                else {
                    self_type = "ERROR"
                }
                //println("called typeOf on rule: " + current_rule + ", expr(child) was of type: " + child1_type + ", Final type was " + self_type)

            case "term term STAR factor" | "term term SLASH factor" | "term term PCT factor" => {
                child1_type = type_of(expr_lvalue_node.children(0), global_symbol_table, function_name)
                child2_type = type_of(expr_lvalue_node.children(2), global_symbol_table, function_name)
                    if (child1_type == "int" && child2_type == "int") {
                        self_type = "int"
                    }
                    else {
                        self_type = "ERROR"
                    }
                }
                //println("called typeOf on rule: " + current_rule + ", term(child1) was of type: " + child1_type + ", factor(child2) was of type: " + child2_type + " Final type was " + self_type)

            case "expr expr PLUS term" =>
                child1_type = type_of(expr_lvalue_node.children(0), global_symbol_table, function_name)
                child2_type = type_of(expr_lvalue_node.children(2), global_symbol_table, function_name)
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
                //println("called typeOf on rule: " + current_rule + ", expr(child1) was of type: " + child1_type + ", term(child2) was of type: " + child2_type + " Final type was " + self_type)


            case "expr expr MINUS term" =>
                child1_type = type_of(expr_lvalue_node.children(0), global_symbol_table, function_name)
                child2_type = type_of(expr_lvalue_node.children(2), global_symbol_table, function_name)
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
               //println("called typeOf on rule: " + current_rule + ", expr(child1) was of type: " + child1_type + ", term(child2) was of type: " + child2_type + " Final type was " + self_type)

            case "factor ID LPAREN RPAREN" => 
                self_type = "int"
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "factor ID LPAREN arglist RPAREN" =>
                self_type = "int"
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)

            case "lvalue STAR factor" =>
                child1_type = type_of(expr_lvalue_node.children(1), global_symbol_table, function_name)
                if (child1_type == "int*") {
                    self_type = "int"
                }
                else {
                    self_type = "ERROR"
                }
                //println("called typeOf on rule: " + current_rule + ", factor(child) was of type: " + child1_type + ", Final type was " + self_type)

            case "lvalue LPAREN lvalue RPAREN" =>
                self_type = type_of(expr_lvalue_node.children(1), global_symbol_table, function_name)
                //println("called typeOf on rule: " + current_rule + ", lvalue(child) was of type: " + child1_type + ", Final type was " + self_type)

            case unexpected_rule => 
                //println("Unexpected rule encountered!! Rule: " + unexpected_rule)
                self_type = "ERROR"
                //println("called typeOf on rule: " + current_rule + " and got type as " + self_type)
        } 
        
        return self_type
    }

    def type_check_expr_lvalue(expr_lvalue_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : String = {
        //println("type check on a expr/lvalue in function " + function_name + " called!! expr/lvalue has rule: " + expr_lvalue_node.rule)
        var types : String = type_of(expr_lvalue_node, global_symbol_table, function_name)
        if (types == "ERROR") {
            //println("ERROR : Type Error in processing expr/lvalue in function: " + function_name + " in rule: " + expr_lvalue_node.rule + ", return type: ERROR")
            Console.err.println("ERROR : Type Error in function: " + function_name + " in rule: " + expr_lvalue_node.rule + ", return type: ERROR")
        }
        else {
            //println("Successful Usage of expr/lvalue in rule: " + expr_lvalue_node.rule + ", type: " + types)
        }
        return types
    }

    def type_check_test(test_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : Unit = {
        //println("type check on a test in function " + function_name + " called!! test has rule: " + test_node.rule)
        var left_expr_node: Tree = test_node.children(0)
        var right_expr_node: Tree = test_node.children(2)
        var left_expr_type: String = type_of(left_expr_node, global_symbol_table, function_name)
        var right_expr_type: String = type_of(right_expr_node, global_symbol_table, function_name)

        if (left_expr_type == right_expr_type && left_expr_type != "ERROR") {
            //println("Well Typed test of rule: " + test_node.rule + " found!! Compared types were: " + left_expr_type)
        }
        else {
            //println("ERROR : Type Error in processing test in function: " + function_name + " in rule: " + test_node.rule + ", return type: ERROR")
            Console.err.println("ERROR : Type Error in function: " + function_name + " in rule: " + test_node.rule + ", return type: ERROR")
        }
    }

    def get_type_from_node(type_node: Tree) : String = {
        var types = "UNINITIALISED_TYPE"
        var type_rule : String = type_node.rule
        type_rule match {
            case "type INT" => types = "int"
            case "type INT STAR" => types = "int*"
            case unexpecte_type => 
                Console.err.println("ERROR : Saw an unexpected rule for type terminal, rule: " + type_rule)
                //println("ERROR : Saw an unexpected rule for type terminal, rule: " + type_rule)
                types = "ERROR"
        }
        return types
    }

    def type_check_dcls(dcls_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : Unit = {
        var dcls_rule : String = dcls_node.rule
        //println ("type check on dcls in function: " + function_name +" called!! dcls has rule: " + dcls_rule)
        dcls_rule match {
            case "dcls dcls dcl BECOMES NUM SEMI" =>
                var type_node = dcls_node.children(1).children(0)
                var types : String = get_type_from_node(type_node)
                if (types == "int") {
                    //println("Successful int declaration!!")
                }
                else {
                    Console.err.println("ERROR : Invalid assignment, expecting int but got " + types)
                    //println("ERROR : Invalid assignment, expecting int but got " + types)
                }
                var child_dcls_node = dcls_node.children(0)
                type_check_dcls(child_dcls_node, global_symbol_table, function_name)

            case "dcls dcls dcl BECOMES NULL SEMI" =>
                var type_node = dcls_node.children(1).children(0)
                var types : String = get_type_from_node(type_node)
                if (types == "int*") {
                    //println("Successful int* declaration!!")
                }
                else {
                    Console.err.println("ERROR : Invalid assignment, expecting int* but got " + types)
                    //println("ERROR : Invalid assignment, expecting int* but got " + types)
                }
                var child_dcls_node = dcls_node.children(0)
                type_check_dcls(child_dcls_node, global_symbol_table, function_name)

            case "dcls" =>
                return

            case unexpected_dcls_rule => 
                Console.err.println("ERROR : Saw an unexpected rule for terminal dcls!! dcls has rule: " + dcls_rule)
                //println("ERROR : Saw an unexpected rule for terminal dcls!! dcls has rule: " + dcls_rule)

        }
    }

    def type_check_statements(StatementS_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], function_name: String) : Unit = {
        var statementS_node : Tree = StatementS_node
        
        var statementS_children_length = statementS_node.children.length
        ////println(statementS_children_length)
        while (statementS_children_length != 0) {
            //println("STATEMENTS has rule: " + statementS_node.rule)
            var statement_node : Tree = statementS_node.children(1)
            var statement_node_rule: String = statement_node.rule
            
            //println("STATEMENT has rule: " + statement_node_rule)
            //println("Parsing the children of STATEMENT now.. STATEMENT has rule " + statement_node_rule)
            var statement_children_nodes : ListBuffer[Tree] = statement_node.children
            
            statement_node_rule match {
                case "statement lvalue BECOMES expr SEMI" =>
                    var lvalue_node: Tree = statement_children_nodes(0)
                    var expr_node: Tree= statement_children_nodes(2)
                    var lvalue_type: String = ""
                    var expr_type: String = ""
                    //println("Calling type_check on lvalue of assignment operator!!")
                    lvalue_type = type_check_expr_lvalue(lvalue_node, global_symbol_table, function_name)
                    //println("Calling type_check on expr of assignment operator!!")
                    expr_type = type_check_expr_lvalue(expr_node, global_symbol_table, function_name)
                    if (lvalue_type == expr_type) {
                        //println("Successful completion of rule: " + statement_node_rule)
                    }
                    else {
                        Console.err.println("ERROR : Invalid use of assignment operator!! Expecting type: " + lvalue_type + ", but recieved: " + expr_type)
                        //println("ERROR : Invalid use of assignment operator!! Expecting type: " + lvalue_type + ", but recieved: " + expr_type)
                    }
 
                case "statement IF LPAREN test RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE" =>
                    var test_node: Tree = statement_children_nodes(2)
                    var nested_statementS_left_node : Tree = statement_children_nodes(5)
                    var nested_statementS_right_node : Tree = statement_children_nodes(9)
                    //println("Calling type_check on test in if statement!!")
                    type_check_test(test_node, global_symbol_table, function_name)
                    //println("Calling type_check on statements in if branch!!")
                    type_check_statements(nested_statementS_left_node, global_symbol_table, function_name)
                    //println("Calling type_check on statements in else branch!!")
                    type_check_statements(nested_statementS_right_node, global_symbol_table, function_name)
                    //println("Evaluation of rule: " +  statement_node_rule + " completed!!")


                case "statement WHILE LPAREN test RPAREN LBRACE statements RBRACE" =>
                    var test_node: Tree = statement_children_nodes(2)
                    var nested_statementS_left_node : Tree = statement_children_nodes(5)
                    //println("Calling type_check on test in while statement!!")
                    type_check_test(test_node, global_symbol_table, function_name)
                    //println("Calling type_check on statements in while loop body!!")
                    type_check_statements(nested_statementS_left_node, global_symbol_table, function_name)
                    //println("Evaluation of rule: " +  statement_node_rule + " completed!!")

                case "statement PRINTLN LPAREN expr RPAREN SEMI" =>
                    var expr_node : Tree = statement_children_nodes(2)
                    var expr_type: String = ""
                    //println("Calling type_check on expr in //println body!!")
                    expr_type = type_check_expr_lvalue(expr_node, global_symbol_table, function_name)
                    if (expr_type == "int") {
                        //println("Successful completion of rule: " + statement_node_rule)
                    }
                    else {
                        Console.err.println("ERROR : Invalid use of //println operator!! Expecting type: int but recieved: " + expr_type)
                        //println("ERROR : Invalid use of //println operator!! Expecting type: int but recieved: " + expr_type)
                    }

                case "statement DELETE LBRACK RBRACK expr SEMI" =>
                    var expr_node : Tree = statement_children_nodes(3)
                    var expr_type: String = ""
                    //println("Calling type_check on expr in delete body!!")
                    expr_type = type_check_expr_lvalue(expr_node, global_symbol_table, function_name)
                    if (expr_type == "int*") {
                        //println("Successful completion of rule: " + statement_node_rule)
                    }
                    else {
                        Console.err.println("ERROR : Invalid use of delete operator!! Expecting type: int* but recieved: " + expr_type)
                        //println("ERROR : Invalid use of delete operator!! Expecting type: int* but recieved: " + expr_type)
                    }

                case unexpected_rule =>
                    //println("ERROR: Ran into an unexpected rule for statement!! Rule: " + statement_node_rule)
                    Console.err.println("ERROR: Ran into an unexpected rule for statement!! Rule: " + statement_node_rule)
            }
        
            //println("Finished Parsing the children of STATEMENT with rule " + statement_node.rule)

            statementS_node = statementS_node.children(0)
            statementS_children_length = statementS_node.children.length

        } 
        //println("STATEMENTS dissappeared and ofcourse has rule: " + statementS_node.rule)
    }

    def type_check_procedures(ParseTree: Tree, global_symbol_table: ListBuffer[FunctionInfo]): Unit = {
        //println("Type check on procedures in the whole Parse Tree called!")
        var procedureS_node: Tree = ParseTree.children(1)
        var procedure_node : Tree = procedureS_node.children(0)
        var function_name : String = procedure_node.children(1).tokens(1)
        var return_type : String = ""
        while (function_name != "wain") {
            var dcls_node = procedure_node.children(6)
            var statementS_node = procedure_node.children(7)
            var return_expr_node = procedure_node.children(9)
            //println("Type check on declarations in function: " + function_name + " has started!!")
            type_check_dcls(dcls_node, global_symbol_table, function_name)
            //println("Type check on declarations in function: " + function_name + " is done!!")
            //println("Type check on statements in function: " + function_name + " has started!!")
            type_check_statements(statementS_node, global_symbol_table, function_name)
            //println("Type check on statements in function: " + function_name + " is done!!")
            //println("Type check on return statement in function: " + function_name + " has started!!")
            return_type = type_check_expr_lvalue(return_expr_node, global_symbol_table, function_name)
            if (return_type != "int") {
                Console.err.println("ERROR : Function " + function_name + " can only return int, but returned type: " + return_type)
                //println("ERROR : Function " + function_name + " can only return int, but returned type: " + return_type)
            }
            else {
                //println("Function " + function_name + " returned successfully!!")
            }
            //println("Type check on return statement in function: " + function_name + " is done!!")
            //println("Type check on function " + function_name + " completed!!")
            procedureS_node = procedureS_node.children(1)
            procedure_node = procedureS_node.children(0)
            function_name = procedure_node.children(1).tokens(1)
        }
        if (function_name == "wain") {
            var dcls_node = procedure_node.children(8)
            var statementS_node = procedure_node.children(9)
            var return_expr_node = procedure_node.children(11)
            //println("Type check on declarations in function: " + function_name + " has started!!")
            type_check_dcls(dcls_node, global_symbol_table, function_name)
            //println("Type check on declarations in function: " + function_name + " is done!!")
            //println("Type check on statements in function: " + function_name + " has started!!")
            type_check_statements(statementS_node, global_symbol_table, function_name)
            //println("Type check on statements in function: " + function_name + " is done!!")
            //println("Type check on return statement in function: " + function_name + " has started!!")
            return_type = type_check_expr_lvalue(return_expr_node, global_symbol_table, function_name)
            if (return_type != "int") {
                Console.err.println("ERROR : Function " + function_name + " can only return int, but returned type: " + return_type)
                //println("ERROR : Function " + function_name + " can only return int, but returned type: " + return_type)
            }
            else {
                //println("Function " + function_name + " returned successfully!!")
            }
            //println("Type check on return statement in function: " + function_name + " is done!!")
            //println("Type check on function " + function_name + " completed!!")
        }
    }

    def get_id_from_factor(expr_node: Tree) : String = {
        return expr_node.children(0).tokens(1)
    }

    def generate_while_start_label() : String = {
        var start_label: String  = "while" + whilecount
        return start_label
    }

    def generate_while_end_label() : String = {
        var end_label: String  = "wend" + whilecount
        whilecount = whilecount + 1
        return end_label
    }

    def generate_if_start_label() : String = {
        var start_label: String  = "if" + ifcount
        return start_label
    }

    def generate_if_end_label() : String = {
        var end_label: String  = "fi" + ifcount
        ifcount = ifcount + 1
        return end_label
    }

    def generate_skip_label(): String = {
        var skip_label : String = "skip" + skipcount
        skipcount = skipcount + 1
        return skip_label
    }

    def generate_code_init() : Unit = {
        wain_first_paramter match {
            case "int" => 
                println("sw $2, -4($30)")
                println("sw $31, -8($30)")
                println("sub $30, $30, $8")
                println("add $2, $0, $0")
                println("jalr $13")
                println("add $30, $30, $8")
                println("lw $31, -8($30)")
                println("lw $2, -4($30)")

            case "int*" =>
                println("sw $31, -4($30)")
                println("sub $30, $30, $4")
                println("jalr $13")
                println("add $30, $30, $4")
                println("lw $31, -4($30)")
        }
    }

    def generate_code_program_prolog() : Unit = {
        println(";;;prolog for entire program has started!!")
        println(".import print")
        println(".import init")
        println(".import new")
        println(".import delete")
        println("lis $12")
        println(".word print")
        println("lis $13")
        println(".word init")
        println("lis $14")
        println(".word new")
        println("lis $15")
        println(".word delete")
        println("lis $4")
        println(".word 4") 
        println("lis $8")
        println(".word 8")
        println("lis $11")
        println(".word 1")
        generate_code_init()
        println(";;;prolog for entire program has ended!!")
        
    }

    def generate_code_init_variables(global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var stack_offset:Int = 0
        for (function_info <- global_symbol_table) {
            if (function_info.name == procedure_name) {
                stack_offset = function_info.symbol_table.size 
                stack_offset = stack_offset * 4
                println(";;code to push stack frame to reserve space for arguments and local variables begins!!")
                println("lis $9")
                println(".word " + stack_offset)
                println("sub $30, $30, $9")
                println(";;code to push stack frame to reserve space for arguments and local variables ends!!")
            }
        }
    }


    def generate_code_function_prolog(global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        println(procedure_name + ": ")
        println(";;; prolog for procedure " + procedure_name + " has started!!")

        println("sub $29, $30, $4  ; point $29 to bottom of stack(for current frame) OR init fp")
        generate_code_init_variables(global_symbol_table , procedure_name)
        //println("sub $30, $30, $8  ; push stack frame")
        
        println(";;;prolog for procedure " + procedure_name + " has ended!!")
        
    }
    
    //
    def generate_code_epilog(): Unit = {
        println(";; epilog         ; pop")
        println("add $30, $29, $4  ; stack")
        println("jr $31            ; frame")
    }

    def generate_code_push_to_reg_3() : Unit = {
        println(";;push the value stored in $3")
        println(";;onto the system stack")
        println("sw $3, -4($30)")
        println("sub $30, $30, $4")
        println(";;push value from $3 to stack completed!!")
    }

    def generate_code_pop_to_5(): Unit = {
        println(";;pop the value off of the system")
        println(";;stack and store it in register $5")
        println("add $30, $30, $4")
        println("lw $5, -4($30)")
        println(";;pop value from stack and store in $5 completed!!")
    }

    def generate_code_NUM(NUM: Int) : Unit = {
        println(";;;starting to generate code for putting NUM in $3!!")
        println("lis $3")
        println(".word " + NUM)
        println(";;;code generated for putting NUM in $3!!")
    }

    def generate_code_NULL() : Unit = {
        println(";;starting to generate code for putting NULL in $3!!")
        println("lis $3")
        println(".word 0x1")
        println(";;;code generation for putting NULL in $3 completed!!")
    }


    def generate_code_factor(factor_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var factor_rule: String = factor_node.rule

        factor_rule match {
            case "factor NUM" => 
                var NUM : Int = factor_node.children(0).tokens(1).toInt
                generate_code_NUM(NUM)

            case "factor NULL" =>
                println("add $3, $0, $11 ;;Code to update $3 as 0x1!! Assigning null to lvalue")


            case "factor AMP lvalue" =>
                var lvalue_child : Tree = factor_node.children(1)
                var lvalue_rule: String = lvalue_child.rule
                lvalue_rule match {
                    case "lvalue ID" =>
                        var variable_id: String = lvalue_child.children(0).tokens(1)
                        var variable_location : Int = get_variable_location(global_symbol_table, procedure_name, variable_id)
                        
                        println(";;Code generation to get $3 <- address of a variable in RAM begins!!")
                        println("lis $3")
                        println(".word " + variable_location)
                        println("add $3, $3, $29")
                        println(";;Code generation to get $3 <- address of a variable in RAM ends!!")

                    case "lvalue STAR factor" =>
                        var factor_child = lvalue_child.children(1)
                        println(";;Case of &(*factor)).. Code generation for factor begins! $3 <- result of factor ")
                        generate_code_factor(factor_child, global_symbol_table, procedure_name)
                        println(";;Code generation for factor ends!! $3 updated to result of factor")

                    case "lvalue LPAREN lvalue RPAREN" =>
                        var lvalue_node = lvalue_child.children(1)
                        generate_code_lvalue(lvalue_node, global_symbol_table, procedure_name)
                }

            case "factor STAR factor" =>
                var factor_child : Tree = factor_node.children(1)
                println(";;Code generation for $3 <- result of factor2 in factor1 -> STAR factor2 begins!!")
                generate_code_factor(factor_child, global_symbol_table, procedure_name)
                println(";;Code generation for factor2 in factor1 -> STAR factor2 ends!! $3 has been updated with result of factor2")
                println("lw $3, 0($3) ;;interpreting what's in $3 as an address and loading contents of address in $3, in $3 itself!!")




            case "factor ID" =>
                var variable_id: String = get_id_from_factor(factor_node)
                var variable_location: Int = get_variable_location(global_symbol_table, procedure_name, variable_id)
                println("lw $3, " + variable_location + "($29) ;;load variable whose offset from frame pointer is " + variable_location + " into $3")

            case "factor LPAREN expr RPAREN" =>
                //TODO: Add comments!! especially what gets stored in $3 <- once generate_code is called!
                generate_code_expr(factor_node.children(1), global_symbol_table, procedure_name)

            case "factor NEW INT LBRACK expr RBRACK" =>
                var expr_child : Tree = factor_node.children(3)
                var skip_label : String = generate_skip_label()
                println(";;starting to generate code to get $3 <- size of array requested!!")
                generate_code_expr(expr_child, global_symbol_table, procedure_name)
                println(";;finished generating code for getting $3 <- size of array requested!!")
                println("add $1, $3, $0  ;;$1 <- size of array requested")
                println(";;Code to allocate memory of size $1 begins!!")
                println("sw $31, -4($30)")
                println("sub $30, $30, $4")
                println("jalr $14")
                println("add $30, $30, $4")
                println("lw $31, -4($30)")
                println(";;Code to allocate memory of size $1 ends!!")
                println("bne $3, $0, " + skip_label + " ;;if $3 == 0 then make $3 <- NULL")
                generate_code_NULL()
                println(skip_label + ": ")

            case "factor ID LPAREN RPAREN" =>
                var called_function : String = get_id_from_factor(factor_node)
                println(";;call to another function made!! Save $29, $31 on stack and call the prolog of called function!!")
                println("sw $29, -4($30)")
                println("sw $31, -8($30)")
                println("sub $30, $30, $8")
                println("lis $5")
                println(".word " + called_function)
                println("jalr $5")
                println(";;returned from callee function, $3 <- return value of called function!!")
                println("add $30, $30, $8")
                println("lw $31, -8($30)")
                println("lw $29, -4($30)")

                
            case unexpected_rule => Console.err.println("Unexpected rule for factor: " + unexpected_rule)

        }
    }

    def generate_code_lvalue(lvalue_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var lvalue_rule : String = lvalue_node.rule

        lvalue_rule match {
            case "lvalue ID" =>
                var variable_id: String = lvalue_node.children(0).tokens(1)
                var variable_location: Int = get_variable_location(global_symbol_table, procedure_name, variable_id)
                println("sw $3, " + variable_location + "($29) ;;store content of $3 in variable whose offset from frame pointer is " + variable_location)

            case "lvalue STAR factor" =>
                println(";;pushing value of expr(stored in $3) onto stack")
                generate_code_push_to_reg_3()
                var factor_child = lvalue_node.children(1)
                println(";;code generation to achieve $3 <- value of factor in lvalue STAR factor!")
                generate_code_factor(factor_child, global_symbol_table, procedure_name)
                println(";;popping value of expr(stored on top of system stack) to $5")
                generate_code_pop_to_5()
                println("sw $5, 0($3) ;;storing value of expr in memory location MEM[$3]")


            case "lvalue LPAREN lvalue RPAREN" =>
                generate_code_lvalue(lvalue_node.children(1), global_symbol_table, procedure_name)
        }
    }

    def generate_code_term(term_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var term_rule = term_node.rule

        term_rule match {
            case "term term STAR factor" =>
                var term_child = term_node.children(0)
                var factor_child = term_node.children(2)
                println(";;code generation to achieve $3 <- result of term2, in term1 -> term2 * factor begins!!")
                generate_code_term(term_child, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of term2, in term1 -> term2 * factor ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of factor, in term1 -> term2 * factor begins!!")
                generate_code_factor(factor_child, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of factor, in term1 -> term2 * factor ends!!")
                generate_code_pop_to_5()
                println("mult $3, $5 ;;$3")
                println("mflo $3     ;;   <- term2 * factor")

            case "term term SLASH factor" =>
                var term_child = term_node.children(0)
                var factor_child = term_node.children(2)
                println(";;code generation to achieve $3 <- result of term2, in term1 -> term2 / factor begins!!")
                generate_code_term(term_child, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of term2, in term1 -> term2 / factor ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of factor, in term1 -> term2 / factor begins!!")
                generate_code_factor(factor_child, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of factor, in term1 -> term2 / factor ends!!")
                generate_code_pop_to_5()
                println("div $5, $3 ;;$3")
                println("mflo $3    ;;   <- term2 / factor")
            
            case "term term PCT factor" =>
                var term_child = term_node.children(0)
                var factor_child = term_node.children(2)
                println(";;code generation to achieve $3 <- result of term2, in term1 -> term2 % factor begins!!")
                generate_code_term(term_child, global_symbol_table, procedure_name) 
                println(";;code generation to achieve $3 <- result of term2, in term1 -> term2 % factor ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of factor, in term1 -> term2 % factor begins!!")
                generate_code_factor(factor_child, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of factor, in term1 -> term2 % factor ends!!")
                generate_code_pop_to_5()
                println("div $5, $3 ;;$3")
                println("mfhi $3    ;;   <- term2 % factor")
            
            case "term factor" =>
                var factor_child = term_node.children(0)
                //TODO: Add comments!! especially what gets stored in $3 <- once generate_code is called!
                generate_code_factor(factor_child, global_symbol_table, procedure_name)
        
        }

    }

    def generate_code_expr(expr_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var expr_rule : String = expr_node.rule

        expr_rule match {
            case "expr expr PLUS term" =>
                var expr_child : Tree = expr_node.children(0)
                var term_child : Tree = expr_node.children(2)
                var expr_type : String = type_of(expr_child, global_symbol_table, procedure_name)
                var term_type : String = type_of(term_child, global_symbol_table, procedure_name)
                if (expr_type == "int" && term_type == "int") {
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!")
                    generate_code_expr(expr_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!")
                    generate_code_push_to_reg_3()
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!")
                    generate_code_term(term_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!")
                    generate_code_pop_to_5()
                    println("add $3, $5, $3 ;; $3 <- expr2 + term")
                }
                else if (expr_type == "int*" && term_type == "int") {
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!")
                    generate_code_expr(expr_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!")
                    generate_code_push_to_reg_3()
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!")
                    generate_code_term(term_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!")
                    println("mult $3, $4 ;;multiply term by 4")
                    println("mflo $3     ;;i.e. the size of one word")
                    generate_code_pop_to_5()
                    println("add $3, $5, $3 ;; $3 <- expr2 + term*4")

                }
                else if(expr_type == "int" && term_type == "int*") {
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term begins!!")
                    generate_code_term(term_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 + term ends!!")
                    generate_code_push_to_reg_3()
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term begins!!")
                    generate_code_expr(expr_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 + term ends!!")
                    println("mult $3, $4 ;;multiply expr2 by 4")
                    println("mflo $3     ;;i.e. the size of one word")
                    generate_code_pop_to_5()
                    println("add $3, $5, $3 ;; $3 <- expr2*4 + term")
                }
                    
            
            case "expr expr MINUS term" =>
                var expr_child : Tree = expr_node.children(0)
                var term_child : Tree = expr_node.children(2)
                var expr_type : String = type_of(expr_child, global_symbol_table, procedure_name)
                var term_type : String = type_of(term_child, global_symbol_table, procedure_name)
                if (expr_type == "int" && term_type == "int") {
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!")
                    generate_code_expr(expr_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!")
                    generate_code_push_to_reg_3()
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!")
                    generate_code_term(term_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!")
                    generate_code_pop_to_5()
                    println("sub $3, $5, $3 ;;$3 <- expr2 - term")
                }
                else if (expr_type == "int*" && term_type == "int") {
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!")
                    generate_code_expr(expr_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!")
                    generate_code_push_to_reg_3()
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!")
                    generate_code_term(term_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!")
                    println("mult $3, $4 ;;multiply term by 4")
                    println("mflo $3     ;;i.e. the size of one word")
                    generate_code_pop_to_5()
                    println("sub $3, $5, $3 ;;$3 <- expr2 - term")
                }

                else if(expr_type == "int*" && term_type == "int*") {
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term begins!!")
                    generate_code_expr(expr_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of expr2, in expr1 -> expr2 - term ends!!")
                    generate_code_push_to_reg_3()
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term begins!!")
                    generate_code_term(term_child, global_symbol_table, procedure_name)
                    println(";;code generation to achieve $3 <- result of term, in expr1 -> expr2 - term ends!!")
                    generate_code_pop_to_5()
                    println("sub $3, $5, $3 ;;$3 <- expr2 - term")
                    println("div $3, $4 ;;divide result by 4")
                    println("mflo $3")
                }
                    
            
            case "expr term" =>
                var term_child = expr_node.children(0)
                //TODO: Add comments!! especially what gets stored in $3 <- once generate_code is called!
                generate_code_term(term_child, global_symbol_table, procedure_name)      
                                
        }            
    }

    def generate_code_test(test_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var test_rule : String = test_node.rule
        test_rule match {
            case "test expr LT expr" =>
                var expr_lchild : Tree = test_node.children(0)
                var expr_rchild : Tree = test_node.children(2)
                var expr_type : String = type_of(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 LT expr2 begins!!")
                generate_code_expr(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 LT expr2 ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 LT expr2 begins!!")
                generate_code_expr(expr_rchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 LT expr2 ends!!")
                generate_code_pop_to_5()
                if (expr_type == "int*") {
                    println("sltu $3, $5, $3 ;;set $3 <- 1 if expr1 < expr2")
                }   
                else {
                    println("slt $3, $5, $3 ;;set $3 <- 1 if expr1 < expr2")
                }
                

            case "test expr EQ expr" =>
                var expr_lchild : Tree = test_node.children(0)
                var expr_rchild : Tree = test_node.children(2)
                var expr_type : String = type_of(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 EQ expr2 begins!!")
                generate_code_expr(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 EQ expr2 ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 EQ expr2 begins!!")
                generate_code_expr(expr_rchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 EQ expr2 ends!!")
                generate_code_pop_to_5()
                if (expr_type == "int*") {
                    println("sltu $6, $3, $5 ;set $6 <- 1 if expr2 < expr1")
                    println("sltu $7, $5, $3 ;set $7 <- 1 if expr1 < expr2")
                }
                else {
                    println("slt $6, $3, $5 ;set $6 <- 1 if expr2 < expr1")
                    println("slt $7, $5, $3 ;set $7 <- 1 if expr1 < expr2")
                }
                
                println("add $3, $6, $7 ;set $3 <- $6 + $7, $6 and $7 cannot both be 1")
                println("sub $3, $11, $3 ;set $3 <- 1 - $3")

            case "test expr NE expr" =>
                var expr_lchild : Tree = test_node.children(0)
                var expr_rchild : Tree = test_node.children(2)
                var expr_type : String = type_of(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 NE expr2 begins!!")
                generate_code_expr(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 NE expr2 ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 NE expr2 begins!!")
                generate_code_expr(expr_rchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 NE expr2 ends!!")
                generate_code_pop_to_5()
                if (expr_type == "int*") {
                    println("sltu $6, $3, $5 ;set $6 <- 1 if expr2 < expr1")
                    println("sltu $7, $5, $3 ;set $7 <- 1 if expr1 < expr2")
                }
                else {
                    println("slt $6, $3, $5 ;set $6 <- 1 if expr2 < expr1")
                    println("slt $7, $5, $3 ;set $7 <- 1 if expr1 < expr2")
                }
                
                println("add $3, $6, $7 ;set $3 <- $6 + $7, $6 and $7 cannot both be 1")

            case "test expr LE expr" =>
                var expr_lchild : Tree = test_node.children(0)
                var expr_rchild : Tree = test_node.children(2)
                var expr_type : String = type_of(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 LE expr2 begins!!")
                generate_code_expr(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 LE expr2 ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 LE expr2 begins!!")
                generate_code_expr(expr_rchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 LE expr2 ends!!")
                generate_code_pop_to_5()
                if (expr_type == "int*") {
                    println("sltu $3, $3, $5 ;;set $3 <- 1, if expr1 > expr2")
                }
                else {
                    println("slt $3, $3, $5 ;;set $3 <- 1, if expr1 > expr2")
                }
                
                println("sub $3, $11, $3 ;; $3 <- not($3)") 


            case "test expr GE expr" =>
                var expr_lchild : Tree = test_node.children(0)
                var expr_rchild : Tree = test_node.children(2)
                var expr_type : String = type_of(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 GE expr2 begins!!")
                generate_code_expr(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 GE expr2 ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 GE expr2 begins!!")
                generate_code_expr(expr_rchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 GE expr2 ends!!")
                generate_code_pop_to_5()
                if (expr_type == "int*") {
                    println("sltu $3, $5, $3 ;;set $3 <- 1, if expr1 < expr2")
                }
                else {
                    println("slt $3, $5, $3 ;;set $3 <- 1, if expr1 < expr2")
                }
                
                println("sub $3, $11, $3 ;; $3 <- not($3)")    

            case "test expr GT expr" =>
                var expr_lchild : Tree = test_node.children(0)
                var expr_rchild : Tree = test_node.children(2)
                var expr_type : String = type_of(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 GT expr2 begins!!")
                generate_code_expr(expr_lchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr1, in test -> expr1 GT expr2 ends!!")
                generate_code_push_to_reg_3()
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 GT expr2 begins!!")
                generate_code_expr(expr_rchild, global_symbol_table, procedure_name)
                println(";;code generation to achieve $3 <- result of expr2, in test -> expr1 GT expr2 ends!!")
                generate_code_pop_to_5()
                if (expr_type == "int*") {
                    println("sltu $3, $3, $5 ;;set $3 <- 1 if expr1 > expr2")
                }
                else {
                    println("slt $3, $3, $5 ;;set $3 <- 1 if expr1 > expr2")
                }
                
        }
    }
   
    def generate_code_statements(StatementS_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {

        var statementS_node : Tree = StatementS_node
        var statementS_children_length = statementS_node.children.length
        if (statementS_children_length != 0) {
            generate_code_statements(statementS_node.children(0), global_symbol_table, procedure_name)
        }
        else {
            return
        }

        var statement_node : Tree = statementS_node.children(1)
        var statement_node_rule: String = statement_node.rule
        var statement_children_nodes : ListBuffer[Tree] = statement_node.children
        
        statement_node_rule match {
            case "statement lvalue BECOMES expr SEMI" =>
                var lvalue_child: Tree = statement_children_nodes(0)
                var expr_child: Tree= statement_children_nodes(2)
                //TODO: NEEDS COMMENTING!!!
                generate_code_expr(expr_child, global_symbol_table, procedure_name)
                generate_code_lvalue(lvalue_child, global_symbol_table, procedure_name)
                

            case "statement IF LPAREN test RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE" =>
                var test_node: Tree = statement_children_nodes(2)
                var nested_statementS_if_node : Tree = statement_children_nodes(5)
                var nested_statementS_else_node : Tree = statement_children_nodes(9)
                var start_label: String = generate_if_start_label()
                var end_label : String = generate_if_end_label()
                println(";; code generation of test condition of if control begins!!")
                generate_code_test(test_node, global_symbol_table, procedure_name)
                println(";; code generation of test condition of if control ends!!")
                println("beq $3, $0, " + start_label + " ;if test false do statements of else")
                println(";; code generation of statements of if control begins!!")
                generate_code_statements(nested_statementS_if_node, global_symbol_table, procedure_name)
                println(";; code generation of statements of if control ends!!")  
                println("beq $0, $0, " + end_label + " ; skip executing statements of else")
                println(start_label + ": ;label indicating beginning of else statements")
                println(";; code generation of statements of else control begins!!")
                generate_code_statements(nested_statementS_else_node, global_symbol_table, procedure_name)
                println(";; code generation of statements of else control ends!!")  
                println(end_label + ": ;label indicating end of else statements")

            case "statement WHILE LPAREN test RPAREN LBRACE statements RBRACE" =>
                var test_node: Tree = statement_children_nodes(2)
                var nested_statementS_node : Tree = statement_children_nodes(5)
                var start_label: String = generate_while_start_label()
                var end_label: String = generate_while_end_label()
                println(start_label + ": ;;start of while label!!")
                println(";; code generation of test condition of while loop begins!!")
                generate_code_test(test_node, global_symbol_table, procedure_name)
                println(";; code generation of test condition of while loop ends!!")
                println("beq $3, $0, " + end_label + " ;;if test false then exit while loop!!")
                println(";; code generation of statements of while loop begins!!")
                generate_code_statements(nested_statementS_node, global_symbol_table, procedure_name) 
                println(";; code generation of statements of while loop ends!!")  
                println("beq $0, $0, " + start_label + " ;;retest while condition!!")
                println(end_label + ": ;;end of while loop!!")                           

            case "statement PRINTLN LPAREN expr RPAREN SEMI" =>
                var expr_child : Tree = statement_children_nodes(2)
                generate_code_expr(expr_child, global_symbol_table, procedure_name)
                println(";;code to print content of $3 begins!!")
                println("sw $1, -4($30)")
                println("sw $31, -8($30)")
                println("sub $30, $30, $8")
                println("add $1, $3, $0")
                println("jalr $12")
                println("add $30, $30, $8")
                println("lw $31, -8($30)")
                println("lw $1, -4($30)")       
                println(";;code to print content of $3 ends!!")                  

            case "statement DELETE LBRACK RBRACK expr SEMI" =>
                var expr_child : Tree = statement_children_nodes(3)
                println(";;code to get $3 <- value of expr to be deleted begins!!")
                generate_code_expr(expr_child, global_symbol_table, procedure_name)
                println(";;code to get $3 <- value of expr to be deleted ends!!")
                println("add $1, $3, $0 ;;$1 <- value of expr to be deleted!!")
                generate_code_NULL()
                var skip_label: String = generate_skip_label()
                println("beq $1, $3, " + skip_label + " ;;skip deleting $1 if $1 == NULL")
                println(";;Code to delete contents of $1 begins!!")
                println("sw $31, -4($30)")
                println("sub $30, $30, $4")
                println("jalr $15")
                println("add $30, $30, $4")
                println("lw $31, -4($30)")
                println(";;Code to delete contents of $1 ends!!")
                println(skip_label + ": ")

                
                
            case unexpected_rule =>                
                Console.err.println("ERROR: Ran into an unexpected rule for statement!! Rule: " + statement_node_rule)
        }
    }

    def generate_code_dcls(Dcls_node: Tree, global_symbol_table: ListBuffer[FunctionInfo], procedure_name: String) : Unit = {
        var dcls_node: Tree = Dcls_node
        var dcls_node_children_length : Int = dcls_node.children.length
        if (dcls_node_children_length != 0) {
            generate_code_dcls(dcls_node.children(0), global_symbol_table, procedure_name)
        } 
        else {
            return
        }
        var dcls_node_rule: String = dcls_node.rule
        dcls_node_rule match {
            case "dcls dcls dcl BECOMES NUM SEMI" =>
                var NUM: Int = dcls_node.children(3).tokens(1).toInt
                generate_code_NUM(NUM)
                var variable_id: String = dcls_node.children(1).children(1).tokens(1)
                var variable_location: Int = get_variable_location(global_symbol_table, procedure_name, variable_id)
                println("sw $3, " + variable_location+"($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is " + variable_location)

            case "dcls dcls dcl BECOMES NULL SEMI" =>
                var variable_id: String = dcls_node.children(1).children(1).tokens(1)
                var variable_location: Int = get_variable_location(global_symbol_table, procedure_name, variable_id)
                generate_code_NULL()
                println("sw $3, " + variable_location+"($29) ;;storing contents of $3(contains initialised value) in variable whose offset from frame pointer is " + variable_location)
        }
    }

    def generate_code_procedure(ProcedureS_node: Tree, global_symbol_table: ListBuffer[FunctionInfo]) : Unit = {
        var procedureS_node: Tree = ProcedureS_node
        var procedure_node: Tree = procedureS_node.children(0)
        var procedure_name : String = procedure_node.children(1).tokens(1)
        
        while (procedure_name != "wain") {
            var params_node = procedure_node.children(3)
            var dcls_node = procedure_node.children(6)
            var statementS_node = procedure_node.children(7)
            var return_expr_node = procedure_node.children(9)
            //TODO: NEEDS COMMENTING!!!
            generate_code_function_prolog(global_symbol_table, procedure_name)
            generate_code_dcls(dcls_node, global_symbol_table, procedure_name)
            generate_code_statements(statementS_node, global_symbol_table, procedure_name)
            generate_code_expr(return_expr_node, global_symbol_table, procedure_name)
            generate_code_epilog()

            procedureS_node = procedureS_node.children(1)
            procedure_node = procedureS_node.children(0)
            procedure_name = procedure_node.children(1).tokens(1)
        }
        if (procedure_name == "wain") {
            var dcl1 = procedure_node.children(3)
            var dcl2 = procedure_node.children(5)
            var dcls_node = procedure_node.children(8)
            var statementS_node = procedure_node.children(9)
            var return_expr_node = procedure_node.children(11)
            //TODO: NEEDS COMMENTING!!!
            generate_code_function_prolog(global_symbol_table, procedure_name)
            println("sw $1, 0($29)     ; store a")
            println("sw $2, -4($29)    ; store b")
            generate_code_dcls(dcls_node, global_symbol_table, procedure_name)
            generate_code_statements(statementS_node, global_symbol_table, procedure_name)
            generate_code_expr(return_expr_node, global_symbol_table, procedure_name)
            generate_code_epilog()
        }

    }

    def generate_code(ParseTree: Tree, global_symbol_table: ListBuffer[FunctionInfo]) : Unit = {
        var procedureS_node: Tree = ParseTree.children(1)
        //Console.err.println("Starting to Generate code!")
        generate_code_program_prolog()
        generate_code_procedure(procedureS_node, global_symbol_table)        
        //Console.err.println("Code generation over!")
    }


    def main (args: Array[String]) : Unit = {   
        var ParseTree: Tree = inOrderCreate()
        var global_symbol_table: ListBuffer[FunctionInfo] = context_sensitive_analysis(ParseTree)
        /*for (function_info <- global_symbol_table) {
            function_info.print_info()
        }*/
        type_check_procedures(ParseTree, global_symbol_table)
        generate_code(ParseTree, global_symbol_table)
    }    
        
}