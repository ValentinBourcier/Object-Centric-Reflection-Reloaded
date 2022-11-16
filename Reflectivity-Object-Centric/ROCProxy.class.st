"
I proxify an object:
- I swap all references of that object by me, and all references to me by the object
- I create a meta-object responsible of taking actions upon reception of a message
- I forward every single message to that meta-object, with the exception of the DNU message
"
Class {
	#name : #ROCProxy,
	#superclass : #nil,
	#instVars : [
		'target',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-instrumentation'
}

{ #category : #'reflective operations' }
ROCProxy >> doesNotUnderstand: aMessage [

	<debuggerCompleteToSender>
	'Proxy receiving: ' crTrace.
	aMessage trace.
	self flag: 'We need to remove the target it is useless'.
	^ metaObject
		  send: aMessage selector
		  withArgs: aMessage arguments
		  to: target
]

{ #category : #'reflective operations' }
ROCProxy >> mop [ 
	^metaObject instrumentedObjectMop
]
