Class {
	#name : #HomeComponent,
	#superclass : #MasterComponent,
	#instVars : [
		'preguntas'
	],
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
HomeComponent >> initialize [
	preguntas := self session model
		ultimasCincoRelevantes: self session usuario
	"	|p t tList rList u1 u2|
	rList:= OrderedCollection new.	
	tList:= OrderedCollection new.
	preguntas:= OrderedCollection new.
	
	usuario:= Usuario newNombreUsuario: 'Manuel' contrasenia:'123'. 
	
	u1:= Usuario newNombreUsuario: 'U1' contrasenia:'123'. 
	u2:= Usuario newNombreUsuario: 'U2' contrasenia:'123'. 
	rList add: (Like newLike: u1).rList add: (Dislike newDislike: u2).
	
	t:= Topico newTopico: 'Objetos' descripcion: 'prueba'.
	tList add:t.
	
	p:= Pregunta newPregunta: 'Orientacion a Objetos' descripcion:'bla bla'  topicos: tList.
	p reacciones: rList.
	preguntas add: p.
	
	p:= Pregunta newPregunta: 'Orientacion a Objetos 2' descripcion:'ble ble ble'  topicos: tList.
	preguntas add: p."
]

{ #category : #accessing }
HomeComponent >> preguntas [
	^ preguntas
]

{ #category : #accessing }
HomeComponent >> preguntas: anObject [
	preguntas := anObject
]

{ #category : #rendering }
HomeComponent >> renderContentOn: aCanvas [
	self renderHeader: aCanvas.
	aCanvas heading with: 'Ultimas preguntas'.
	aCanvas div
		id: 'agregarPregunta';
		with: [ aCanvas anchor
				callback: [ self call: NuevaPreguntaComponent new ];
				with: [ aCanvas button with: 'Hacer una nueva pregunta' ] ].
	aCanvas horizontalRule.
	aCanvas
		unorderedList: [ preguntas
				do: [ :pregunta | 
					self renderPregunta: pregunta canvas: aCanvas.
					aCanvas horizontalRule ] ]
]

{ #category : #accessing }
HomeComponent >> style [
	^ '
	#usuarioencabezado{
		text-align:right;
		margin-right:50px;
		font-weight: bold;
	}
	
	#agregarPregunta{text-align:right;
	}
	#titulo{
				font-size: 21;						
		 		text-align: center;			
			}
	#perfilUri{
	color: #3399ff;
	font-weight: bold;
	}
	'
]
