"
My job is to intercept a message send corresponding to a specific selector, and to forward that message send with its potential arguments to a meta-object.  

I am designed to be instantiated for a unique metalink that will execute me when firing at runtime.
"
Class {
	#name : #ROCMessageInterceptor,
	#superclass : #Object,
	#instVars : [
		'selector',
		'metaObject'
	],
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCMessageInterceptor >> execute [

	<debuggerCompleteToSender>
	^ metaObject receive: selector
]

{ #category : #execution }
ROCMessageInterceptor >> executeWithArgs: args [

	<debuggerCompleteToSender>
	"receive all sends filter by self if the receiver is the object who insrument if yes propagate and then call my method to do reflective part"
	^ metaObject receive: selector withArgs: args
	"linkInsteadMessageSend:withValue:"
	
]

{ #category : #'as yet unclassified' }
ROCMessageInterceptor >> metaObject [
	^ metaObject
]

{ #category : #accessing }
ROCMessageInterceptor >> metaObject: anObject [

	metaObject := anObject
]

{ #category : #'as yet unclassified' }
ROCMessageInterceptor >> selector [
	^ selector
]

{ #category : #accessing }
ROCMessageInterceptor >> selector: anObject [

	selector := anObject
]
