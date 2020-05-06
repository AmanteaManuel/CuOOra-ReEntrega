"
clase que modela una Pregunta en el sistema, la misma hereda del posteo.
"
Class {
	#name : #Respuesta,
	#superclass : #Post,
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Respuesta class >> newRespuesta: descripcionStr usuario:anUser [
	^ self new descripcion: descripcionStr usuario:anUser.
]

{ #category : #initialization }
Respuesta >> descripcion: descripcionStr usuario:anUser [
	descripcion := descripcionStr.
	usuario := anUser.
]

{ #category : #initialization }
Respuesta >> initialize [
	self
		activo: true; fecha: Date today; hora: Time now; 
		reacciones: OrderedCollection new.
]

{ #category : #methods }
Respuesta >> soyPregunta [
	^false.
]
