import scala.io.StdIn.{readLine, readInt}
import scala.collection.mutable.ListBuffer
object DFA {
	def main(args: Array[String]): Unit = {

	}

	def get_alphabets() : ListBuffer[String] = {
		var no_of_alphabets: Int = readInt()
		var alphabets : ListBuffer[String] 
		for (count <- 1 to no_of_alphabets) {
			var input = readLine()
			alphabets = alphabets + input
		}
		return alphabets
	}

	def get_states(): = {

	}

	def get_initial_state(): = {

	}

	def get_accepting_states(): = {

	}
	def get_transitions(): = {

	}
}
