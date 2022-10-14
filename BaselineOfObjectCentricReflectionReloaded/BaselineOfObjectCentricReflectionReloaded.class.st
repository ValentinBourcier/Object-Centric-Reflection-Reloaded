Class {
	#name : #BaselineOfObjectCentricReflectionReloaded,
	#superclass : #BaselineOf,
	#category : #BaselineOfObjectCentricReflectionReloaded
}

{ #category : #baselines }
BaselineOfObjectCentricReflectionReloaded >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		spec
			package: 'Reflectivity-Object-Centric';
			package: 'Reflectivity-Object-Centric-Tests'
			with: [ spec requires: 'Reflectivity-Object-Centric' ];
			package: 'Reflectivity-Object-Centric-Visualization'
			with: [ spec requires: 'Reflectivity-Object-Centric' ].


		spec
			group: 'default'
			with:
				#( 'Reflectivity-Object-Centric' 'Reflectivity-Object-Centric-Tests'
				   'Reflectivity-Object-Centric-Visualization' ) ]
]
