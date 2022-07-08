"
I proxify an object:
- I swap all references of that object by me, and all references to me by the object
- I create a meta-object responsible of taking actions upon reception of a message
- I forward every single message to that meta-object, with the exception of the DNU message
"
Class {
	#name : #RFProxy,
	#superclass : #nil,
	#instVars : [
		'target',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #proxy }
RFProxy class >> becomeTarget: anObject [
	| proxy metaObject|
	proxy := self basicNew.
	anObject become: proxy.
	
	"After the become, proxy and anObject have been swapped"	
	metaObject := RFProxyMetaObject forObject: proxy proxy: anObject.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #target) index put: proxy.
	MirrorPrimitives fixedFieldOf: anObject at: (self slotNamed: #metaObject) index put: metaObject.
	
	^ anObject
]

{ #category : #'reflective operations' }
RFProxy >> doesNotUnderstand: aMessage [
	<debuggerCompleteToSender>
	'Proxy receiving: ' crTrace.
	aMessage trace. 
	^ metaObject send: aMessage selector withArgs: aMessage arguments to: target
]
