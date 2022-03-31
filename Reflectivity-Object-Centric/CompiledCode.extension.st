Extension { #name : #CompiledCode }

{ #category : #'*Reflectivity-Object-Centric' }
CompiledCode >> hasSuperSends [

	^ self ast sendNodes anySatisfy: [ :msgNode | msgNode isSuperSend ]
]
