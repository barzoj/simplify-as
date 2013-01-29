/*
* Copyright (c) 2013 Cactussoft <denis.borzakovsky@cactussoft.biz>
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
* 
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
*/

package test.biz.cactussoft.serialization
{
	import biz.cactussoft.serialization.simplify;
	
	import com.adobe.serialization.json.JSON;
	import com.furusystems.logging.slf4as.global.debug;
	
	import flexunit.framework.Assert;
	
	import test.biz.cactussoft.serialization.models.*;
	
	public class SimplifyTest
	{		
		
		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testSimplifyOnSimple():void
		{
			var e : Employee = new Employee();
			e.Age = 25;
			e.FirstName = "John";
			e.LastName = "Smith";
			e.OutOfOffice = false;
			
			trace( com.adobe.serialization.json.JSON.encode( e ) );
			var s : String = com.adobe.serialization.json.JSON.encode( e );
			var new_e : Employee = simplify( com.adobe.serialization.json.JSON.decode( s ), Employee  );
			
			Assert.assertEquals( e.Age, new_e.Age );
			Assert.assertEquals( e.FirstName, new_e.FirstName );
			Assert.assertEquals( e.LastName, new_e.LastName );
			Assert.assertEquals( e.OutOfOffice, new_e.OutOfOffice );
		}
		
		[Test]
		public function testSimplifyOnNested() : void
		{
			var a : Employee = new Employee();
			a.Age = 25;
			a.FirstName = "John";
			a.LastName = "Smith";
			a.OutOfOffice = false;
			
			
			var b : Employee = new Employee();
			b.Age = 30;
			b.FirstName = "Mike";
			b.LastName = "Stuart";
			b.OutOfOffice = true;
			
			
			var c : Employee = new Employee();
			c.Age = 30;
			c.FirstName = "Ada";
			c.LastName = "Lovelas";
			c.OutOfOffice = true;
			
			var o  : Organisation = new Organisation();
			o.Name = "BlaBlaSoft";
			o.CTO = a;
			o.Employes = new Array();
			o.Employes.push( a, b, c );
			
			var s : String = com.adobe.serialization.json.JSON.encode( o );
			trace( s );
			var new_o : Organisation = simplify( com.adobe.serialization.json.JSON.decode( s ), Organisation  );
			Assert.assertEquals( new_o.CTO.Age, o.CTO.Age );
			Assert.assertEquals( new_o.CTO.FirstName, o.CTO.FirstName );
			Assert.assertEquals( new_o.CTO.LastName, o.CTO.LastName );
			Assert.assertEquals( new_o.CTO.OutOfOffice, o.CTO.OutOfOffice );
			
			Assert.assertEquals( new_o.Name, o.Name );
			trace( com.adobe.serialization.json.JSON.encode( new_o ) );
		}
	}
}