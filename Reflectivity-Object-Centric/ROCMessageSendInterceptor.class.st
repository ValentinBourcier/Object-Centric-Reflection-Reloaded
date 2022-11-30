"
I am the Interceptor for messageSend, I have as arguments the reification arguments , for message send nodes
"
Class {
	#name : #ROCMessageSendInterceptor,
	#superclass : #ROCAbstractInterceptor,
	#category : #'Reflectivity-Object-Centric-interceptors'
}

{ #category : #execution }
ROCMessageSendInterceptor >> execute: anOperation [
	anOperation receiver == self receiver ifTrue: [ 
		metaObject instrumenter
			instrumentSelector: anOperation selector
			withArgs: anOperation arguments ].
	^ metaObject executeReflectiveOperationsForMessageSendOperation:
		  anOperation
]

{ #category : #override }
ROCMessageSendInterceptor >> execute: aName withValue: aValue [
]
