// http://ideone.com/sVmVJJ
using System;
using System.Reflection;
using System.Linq;
using System.Collections.Generic;

public interface MyProtocol {
  void HelloWorld();
}

public class MyClass : MyProtocol {
  public void HelloWorld() {
    Console.WriteLine("hello world");
  }
}

public class Test
{
	public static void Main()
	{
		var assemblies = AppDomain.CurrentDomain.GetAssemblies();
		var all_types = assemblies.SelectMany((_) => _.GetTypes());
		var filtered_types = all_types.Where(
			(_) => _.GetInterfaces().Any (
				(i) => i == typeof(MyProtocol)
			)
		).ToArray();
		MyProtocol instance = Activator.CreateInstance(filtered_types[0]) as MyProtocol;
		instance.HelloWorld();
	}
}