import scala.io.StdIn.{readLine, readInt}
import scala.collection.mutable.ListBuffer

object Trees {
	def main (args: Array[String]) : Unit = {		
		inOrderCreate()
	}

	
	def getInputs() : Array[Int] = {
        val input = readLine()
        if (input == null) {
        	val eof: Array[Int] = Array(-1,-1)
        	return eof
        }
        var arr : Array[Int] = input.split(" ").map(x => x.toInt)
        //println("Accepted values "+ arr(0)+ ", " + arr(1))
        return arr
    }


    class Tree(var value: Int, var children: ListBuffer[Tree]) {
    	def addChild( child: Tree) : Unit = {
    		children += child
    	}    
    	

    	def insertChild(noofchildren: Int): Unit = {
    		var noofchildren2: Int = noofchildren
    		if (noofchildren2 == 0) {
    			return
    		}
    		else {
    			noofchildren2 = noofchildren2 - 1
    			var input: Array[Int] = getInputs()
    			var input_value: Int = input(0)
    			var input_noofchildren: Int  = input(1)
    			/*if (input_noofchildren == -1) {
    				return
    			}*/
    			var newchild: Tree = new Tree(input_value, new ListBuffer[Tree])
    			addChild(newchild)
    			children(children.length-1).insertChild(input_noofchildren)
    			insertChild(noofchildren2)
    		}
    	}


    	def postorder(): Unit = {
    		if (children.length==0) {
    			println(value + " " + 0)
    		}
    		else {
    			for (i <- children) {
    				i.postorder
    			}
    			println(value + " " + children.length)
    		}
    	}
	}

	def inOrderCreate() : Unit = {
		var input : Array[Int] = getInputs()
		var input_value: Int = input(0)
		var input_noofchildren: Int = input(1)
		var finaltree : Tree = new Tree(input_value, new ListBuffer[Tree])
		finaltree.insertChild(input_noofchildren)
		finaltree.postorder
    }
}


