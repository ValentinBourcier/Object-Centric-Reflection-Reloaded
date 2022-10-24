"
I am the Interceptor for Variable read, I have as arguments the reification arguments , for Variable read nodes

Object>> m1: arg1

	var1 := value1 + value2 + arg1
	
The only variable read in that example are just value1 and value2
"
Class {
	#name : #ROCVariableReadInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCVariableReadInterceptor >> execute: aOperation [
]

{ #category : #override }
ROCVariableReadInterceptor >> execute: aName withValue: aValue [

	^ metaObject linkInsteadVariableRead: aName withValue: aValue
]
