Class {
	#name : #ROCMessageInterceptorTest,
	#superclass : #TestCase,
	#instVars : [
		'interceptor',
		'tag'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #helpers }
ROCMessageInterceptorTest >> receive: selector [

	tag := selector
]

{ #category : #helpers }
ROCMessageInterceptorTest >> receive: selector withArgs: args [
	
	tag := { selector. args }
]

{ #category : #tests }
ROCMessageInterceptorTest >> setUp [
	super setUp.
	interceptor := ROCMessageInterceptor new.
	interceptor selector: #yourself.
	interceptor metaObject: self
]

{ #category : #tests }
ROCMessageInterceptorTest >> testExecute [
	interceptor execute.

	self assert: tag equals: #yourself
]

{ #category : #tests }
ROCMessageInterceptorTest >> testExecuteWithArgs [
	|array|
	array := {Object new}.
	interceptor executeWithArgs: array.
	self assert: tag first equals: #yourself.
	self assert: tag second identicalTo: array
]
