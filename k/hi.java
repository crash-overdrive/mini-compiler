import java.util.Scanner;

class helloworld
{
	public static void main(String[] args) 
	{
		Scanner sc = new Scanner(System.in);
		System.out.println("i am a potato");
		int a =2;
		System.out.println("Value of a is: " + a);
		a = 2;
		System.out.println("Value of a is: " + a);
		a = a -1;
		System.out.println("Value of a is: " + a);
		a =a *2;
		System.out.println("Value of a is: " + a);
		a = a/2;
		System.out.println("Value of a is: " + a);
		a = a + 1 * 2;
		System.out.println("Value of a is: " + a);
		
		System.out.println("Value of a is: " + a);

		int input_int;

		byte scb;
		short scc;
		long scd;
		String sce;
		boolean scf;
		
		System.out.println("Enter int value: ");
		input_int = sc.nextInt();
		System.out.println("Int value inputted was: " + input_int);

		input_int = input_int * 2;
		System.out.println("First Int value multiplied by 2 was: " + input_int);

		System.out.print("Enter second int value: ");
		int second_input_int = sc.nextInt();
		System.out.println("Int value inputted was: " + second_input_int);

		second_input_int = second_input_int * 3;
		System.out.println("Second Int value multiplied by 3 was: " + second_input_int);


		System.out.print("Enter byte value: ");
		System.out.print("Enter short value: ");
		System.out.print("Enter long value: ");
		System.out.print("Enter String value: ");
		System.out.print("Enter boolean value: ");
		//fun();

	}


	static void fun() {
		System.out.println("I am a fun function!!");
	}
}

