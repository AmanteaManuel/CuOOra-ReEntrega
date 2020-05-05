"
clase que modela una Respuesta en el sistema, la misma hereda del posteo.
"
Class {
	#name : #Pregunta,
	#superclass : #Post,
	#instVars : [
		'titulo',
		'respuestas',
		'topicos'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Pregunta class >> newPregunta:tituloStr descripcion:descripcionStr topicos:topicosList [
	^ self new	
		titulo: tituloStr; descripcion: descripcionStr; topicos: topicosList.
]

{ #category : #'instance creation' }
Pregunta class >> newPregunta: tituloStr descripcion: descripcionStr topicos: topicosList usuario:anUser [
	^ self new
		titulo: tituloStr;
		descripcion: descripcionStr;
		topicos: topicosList;
		usuario:anUser.
]

{ #category : #methods }
Pregunta >> agregarRespuesta:respuestaObj [
	respuestas add: respuestaObj.
]

{ #category : #accesing }
Pregunta >> cantidadRespuestas [

	^(self respuestas size).
]

{ #category : #initialization }
Pregunta >> initialize [
	self
		activo: true; 
		fecha: Date today; 
		hora: Time now;
		reacciones: OrderedCollection new; 
		respuestas: OrderedCollection new.
		
]

{ #category : #methods }
Pregunta >> obtenerRespuestasPorPuntaje [
	| list |
	list := SortedCollection new.
	list := respuestas
		asSortedCollection: [ :r1 :r2 | r1 diferenciaLikesDislikes > r2 diferenciaLikesDislikes ].
	^ list
]

{ #category : #methods }
Pregunta >> perteneceATopico:unTopico [
	^ topicos includes:unTopico
]

{ #category : #accesing }
Pregunta >> respuestas [
	^ respuestas.
]

{ #category : #accesing }
Pregunta >> respuestas: list [
	respuestas:= list.
]

{ #category : #methods }
Pregunta >> soyPregunta [
	^true.
]

{ #category : #accesing }
Pregunta >> titulo [
	^ titulo.
]

{ #category : #accesing }
Pregunta >> titulo:unString [
	titulo := unString.
]

{ #category : #accesing }
Pregunta >> topicos [ 
	^ topicos.
]

{ #category : #accesing }
Pregunta >> topicos: list [
	topicos:= list.
]

{ #category : #methods }
Pregunta >> topicosComoString [
	^ (self topicos collect: [ :each | each nombre ]) asCommaString.
]
