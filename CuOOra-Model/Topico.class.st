"
clase que modela un Tag/#/Topico en el sistema
"
Class {
	#name : #Topico,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'descripcion'
	],
	#category : #'CuOOra-Model'
}

{ #category : #'instance creation' }
Topico class >> newTopico:nombreStr descripcion:descripcionStr [
	^ self new
		nombre: nombreStr; 
		descripcion: descripcionStr.
]

{ #category : #accesing }
Topico >> descripcion [
	^descripcion.
]

{ #category : #accesing }
Topico >> descripcion:unaDescripcion [
	descripcion:= unaDescripcion.
]

{ #category : #methods }
Topico >> existeNombre: nombreStr [
	^ nombre = nombreStr.
	
]

{ #category : #accesing }
Topico >> nombre [
	^nombre.
	
]

{ #category : #accesing }
Topico >> nombre:unNombreStr [
	nombre:= unNombreStr.
	
]
