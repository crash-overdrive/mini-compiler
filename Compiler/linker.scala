import scala.collection.mutable.ListBuffer
import scala.io.Source

object Linker {
	case class MerlFile(filename: String, filelength: Int, codelength: Int, filecontent: ListBuffer[String], 
						code: ListBuffer[String], ESR: ListBuffer[String], ESD: ListBuffer[String], RE: ListBuffer[String]) {		

	}



	def get_header(filecontent: ListBuffer[String]) : (Int, String) = {
		var filelength = Integer.parseInt(filecontent(1).split(" ")(1) + filecontent(1).split(" ")(2), 16)
		var codelength = Integer.parseInt(filecontent(2).split(" ")(1) + filecontent(2).split(" ")(2), 16)
		println(filelength)
		println(codelength)
		return (filelength, codelength)
	}

	def get_code() : Unit = {

	}

	def get_REST() : Unit = {

	}

	def main(args: Array[String]): Unit = {
		var no_of_args : Int = args.length
		for (arg <- args) {
			var merlfilecontent: ListBuffer[String] = ListBuffer() 
			Source.fromFile(arg).getLines().copyToBuffer(merlfilecontent)
			println(merlfilecontent.length)
			var (filelength, codelength) = get_header(merlfilecontent)
			println(merlfilecontent.length)
			//var merlfile : MerlFile = new MerlFile(arg, 0, 0, , ListBuffer(), ListBuffer(), ListBuffer(), ListBuffer())
			
		}
	}




}