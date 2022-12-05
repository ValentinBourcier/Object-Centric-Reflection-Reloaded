"
I am the Interceptor for Variable Write, I have as arguments the reification arguments , for Assignments nodes. There is an example below:

Object>> m1: arg1

var1 := value1 + value2 + arg1

The only variable write in that example are  var1 :=


"
Class {
	#name : #ROCVariableWriteInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #override }
ROCVariableWriteInterceptor >> execute: aOperation [
	"USING THIS"
	^ metaObject executeReflectiveOperationsForAssignment: aOperation
]

{ #category : #override }
ROCVariableWriteInterceptor >> execute: aName withValue: aValue [
	"NOT USING, VALUES HAVENT A GOOD VALUE"
	^ metaObject executeReflectiveOperationsForAssignment: aName withValue: aValue
]
