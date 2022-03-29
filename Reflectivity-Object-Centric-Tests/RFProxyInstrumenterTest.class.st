Class {
	#name : #RFProxyInstrumenterTest,
	#superclass : #TestCase,
	#instVars : [
		'instrumenter',
		'testObject'
	],
	#category : #'Reflectivity-Object-Centric-Tests'
}

{ #category : #tests }
RFProxyInstrumenterTest >> setUp [
	super setUp.
	instrumenter := RFProxyInstrumenter for: self.
	testObject := Object new
]

{ #category : #tests }
RFProxyInstrumenterTest >> testBeForObject [
	
	instrumenter beForObject: testObject.
	self assert: instrumenter instrumentedObject identicalTo: testObject.
	self assert: instrumenter instrumentedClass identicalTo: testObject class.
	self assert: instrumenter instrumentedClass isAnonymous.
	self assert: instrumenter instrumentedClass superclass identicalTo: Object
]

{ #category : #tests }
RFProxyInstrumenterTest >> testInstantiation [

	self assert: instrumenter metaObject identicalTo: self
]

{ #category : #tests }
RFProxyInstrumenterTest >> testInstrumentedMessages [
	|im|
	im := instrumenter instrumentedMessages .
	self assert: im size equals: 1.
	self assert: (im includes: #class).
]

{ #category : #tests }
RFProxyInstrumenterTest >> testNewLinkForSelector [
	|link interceptor|
	
	link := instrumenter newLinkForSelector: #selector.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #execute.
	self assertEmpty: link arguments.
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector.
	self assert: interceptor metaObject equals: instrumenter metaObject.

	
	link := instrumenter newLinkForSelector: #selector:.	
	self assert: link control equals: #instead.
	self assert: link selector equals: #executeWithArgs:.
	self assert: link arguments equals: #(arguments).
	self assert: link optionCompileOnLinkInstallation.
	
	interceptor := link metaObject.	
	self assert: interceptor selector identicalTo: #selector:.
	self assert: interceptor metaObject equals: instrumenter metaObject

	
]
