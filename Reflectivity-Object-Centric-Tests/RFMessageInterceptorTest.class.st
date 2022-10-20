Class {
	#name : #RFMessageInterceptorTest,
	#superclass : #TestCase,
	#instVars : [
		'interceptor',
		'tag'
	],
	#category : #'Reflectivity-Object-Centric-Tests-tests'
}

{ #category : #helpers }
RFMessageInterceptorTest >> receive: selector [

	tag := selector
]

{ #category : #helpers }
RFMessageInterceptorTest >> receive: selector withArgs: args [
	
	tag := { selector. args }
]

{ #category : #tests }
RFMessageInterceptorTest >> setUp [
	super setUp.
	interceptor := RFMessageInterceptor new.
	interceptor selector: #yourself.
	interceptor metaObject: self
]

{ #category : #tests }
RFMessageInterceptorTest >> testExecute [
	interceptor execute.

	self assert: tag equals: #yourself
]

{ #category : #tests }
RFMessageInterceptorTest >> testExecuteWithArgs [
	|array|
	array := {Object new}.
	interceptor executeWithArgs: array.
	self assert: tag first equals: #yourself.
	self assert: tag second identicalTo: array
]
