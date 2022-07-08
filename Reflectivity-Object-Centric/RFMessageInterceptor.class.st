"
My job is to intercept a message send corresponding to a specific selector, and to forward that message send with its potential arguments to a meta-object.  

I am designed to be instantiated for a unique metalink that will execute me when firing at runtime.
"
Class {
	#name : #RFMessageInterceptor,
	#superclass : #Object,
	#instVars : [
		'selector',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric'
}

{ #category : #execution }
RFMessageInterceptor >> execute [

	<debuggerCompleteToSender>
	^ metaObject receive: selector
]

{ #category : #execution }
RFMessageInterceptor >> executeWithArgs: args [

	<debuggerCompleteToSender>
	^ metaObject receive: selector withArgs: args
]

{ #category : #accessing }
RFMessageInterceptor >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #accessing }
RFMessageInterceptor >> selector: anObject [

	selector := anObject
]
