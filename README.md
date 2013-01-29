simplify-as
==================

Small Actionscript library to convert anonymous object to a typed instance

Usage:
------------------

import biz.cactussoft.serialization.simplify;

import com.adobe.serialization.json.JSON;


var s : String = '{"LastName":"Smith","Age":25,"OutOfOffice":false,"FirstName":"John"}';

var e : Employee = simplify( com.adobe.serialization.json.JSON.decode( s ), Employee  );

------------------
This utility is recursive and can be used to translate anonymous instances with nested objects. 