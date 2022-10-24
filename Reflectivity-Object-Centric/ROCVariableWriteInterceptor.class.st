"
I am the Interceptor for Variable Write, I have as arguments the reification arguments , for Assignments nodes

Object>> m1: arg1

var1 := value1 + value2 + arg1

The only variable write in that example are  var1 :=


"
Class {
	#name : #ROCVariableWriteInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCVariableWriteInterceptor >> execute: aOperation [
	"USING THIS"
	^ metaObject linkInsteadAssignment: aOperation
]

{ #category : #override }
ROCVariableWriteInterceptor >> execute: aName withValue: aValue [
	"NOT USING, VALUES HAVENT A GOOD VALUE"
	^ metaObject linkInsteadAssignment: aName withValue: aValue
]
