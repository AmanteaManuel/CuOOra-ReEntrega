"
""
|app|
app := WAAdmin register: AccessGrantingComponent asApplicationAt: 'CuOOra'.
app sessionClass: SessionWithUser. 

Smalltalk garbageCollect ""
"
Class {
	#name : #AccessGrantingComponent,
	#superclass : #WAComponent,
	#instVars : [
		'nombreUsuario',
		'contrasenia'
	],
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
AccessGrantingComponent >> contrasenia [
	^ contrasenia
]

{ #category : #accessing }
AccessGrantingComponent >> contrasenia: anObject [
	contrasenia := anObject
]

{ #category : #accessing }
AccessGrantingComponent >> initialize [
	super initialize.
]

{ #category : #rendering }
AccessGrantingComponent >> login: anUser [
	(self model
		nombreUsuario: anUser nombreUsuario
		contrasenia: anUser contrasenia)
		ifNotNil: [ :u | self proceedWith: u ].	
	nombreUsuario := nil.
	contrasenia := nil.
	self call: (ErrorLoginComponent new)

]

{ #category : #model }
AccessGrantingComponent >> model [
	^ CuOOra soleInstance
]

{ #category : #accessing }
AccessGrantingComponent >> nombreUsuario [
	^ nombreUsuario
]

{ #category : #accessing }
AccessGrantingComponent >> nombreUsuario: anObject [
	nombreUsuario := anObject
]

{ #category : #rendering }
AccessGrantingComponent >> proceedWith: unUsuario [
	self session usuario: unUsuario.
	self session model: self model.
	self call: HomeComponent new
]

{ #category : #rendering }
AccessGrantingComponent >> renderBody: aCanvas [
	| logueo |
	logueo := Usuario new.
	aCanvas div
		id: 'body';
		with: [ aCanvas
				form: [ aCanvas text: 'Nombre de usuario'.
					aCanvas break.
					aCanvas textInput
															
						callback: [ :value | logueo nombreUsuario: value ].
					aCanvas break.
					aCanvas break.
					aCanvas text: 'Contraseña: '.
					aCanvas break.
					aCanvas textInput
					type: 'password';	
						callback: [ :value | logueo contrasenia: value ].
					aCanvas break.
					aCanvas break.
					aCanvas submitButton
						callback: [ self login: logueo ];
						with: 'Ingresar' ] ]
]

{ #category : #rendering }
AccessGrantingComponent >> renderContentOn: aCanvas [	
	self renderHeader: aCanvas.
	self renderBody: aCanvas.
	
]

{ #category : #rendering }
AccessGrantingComponent >> renderErrorPage:aCanvas [
]

{ #category : #rendering }
AccessGrantingComponent >> renderHeader: aCanvas [	
	aCanvas div id:'titulo'; with: [ 		aCanvas heading with: 'CuOOra'.
	].
	aCanvas horizontalRule
]

{ #category : #rendering }
AccessGrantingComponent >> style [
	^ '
	#titulo{
				font-size: 21;						
		 		text-align: center;
			}
			
	#body{
				font-size: 21;						
		 		text-align: center;
				margin-top: 100px;

			}		
					
	#error{ color: red;}
		'
]
