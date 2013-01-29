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

package biz.cactussoft.serialization
{
	import flash.system.ApplicationDomain;
	import flash.utils.describeType;
	
	
	/**
	 * Converts an anonymous object to an instance of the class passed as the second variable.  
	 * @param pObject anonymous object
	 * @param pTargetClass Target type
	 */
	public function simplify( pObject : Object, pTargetClass : Class ) : * 
	{
		var typeDescription : XML = describeType( pTargetClass );
		for ( var paramIter:String in typeDescription.factory.variable )
		{
			if ( typeDescription.factory.variable.@type[paramIter].toString().indexOf( "::" ) != -1 )
			{
				var nestedClassTypeName : String = typeDescription.factory.variable.@type[paramIter].toString().replace( /::/, "." );
				var paramName : String =  typeDescription.factory.variable.@name[paramIter].toString();
				var nestedClass : Class = ApplicationDomain.currentDomain.getDefinition( nestedClassTypeName ) as Class;
				pObject[ paramName ] = simplify( pObject[ paramName ], nestedClass );
			}
		}
		
		var simple : Object = new pTargetClass();
		for ( var attr : String in pObject )
			simple[attr] = pObject[attr];
		
		return simple;
	}
}