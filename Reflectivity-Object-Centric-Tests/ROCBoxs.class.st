Class {
	#name : #ROCBoxs,
	#superclass : #ROCCase,
	#instVars : [
		'height',
		'width',
		'depth',
		'boxWeight'
	],
	#category : #'Reflectivity-Object-Centric-Tests-utils'
}

{ #category : #accessing }
ROCBoxs >> boxWeight [

	^ boxWeight
]

{ #category : #accessing }
ROCBoxs >> boxWeight: anObject [

	boxWeight := anObject
]

{ #category : #accessing }
ROCBoxs >> calculateBoxWeight [

	boxWeight := width * height * depth * 0.001
]

{ #category : #accessing }
ROCBoxs >> depth [

	^ depth
]

{ #category : #accessing }
ROCBoxs >> depth: anObject [

	depth := anObject
]

{ #category : #accessing }
ROCBoxs >> height [

	^ height
]

{ #category : #accessing }
ROCBoxs >> height: anObject [

	height := anObject
]

{ #category : #'api - accessing' }
ROCBoxs >> weight [ 

	super weight + boxWeight
]

{ #category : #accessing }
ROCBoxs >> width [

	^ width
]

{ #category : #accessing }
ROCBoxs >> width: anObject [

	width := anObject
]
