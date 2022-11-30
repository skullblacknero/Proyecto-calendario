// Mostrar� por pantalla una hoja de calendario de un mes y a�o
// que se pedir� al usuario por teclado. 
// El valor del a�o estar� entre 1601 y 3000
Algoritmo calendario
	// Declaraci�n de variables
	Definir year,month Como Entero;
	Definir S Como Logico;
	Definir seguir Como Caracter;
	S <- Verdadero;
	Mientras S Hacer
		// Pedir por teclado el mes
		Escribir '�Mes (1..12)? ' Sin Saltar;
		Leer month;
		// Comprueba que el mes sea correcto
		Si (month>=1 Y month<=12) Entonces
			// Pedir por teclado el a�o
			Escribir '�A�o (1601...3000)? ' Sin Saltar;
			Leer year;
			// Comprueba que el a�o sea correcto
			Si (year<1601 O year>3000) Entonces
				Escribir 'A�o incorrecto';
			SiNo
				drawMonth(year,month); // Dibuja la hoja de calendario
				Escribir ' ';
			FinSi
		SiNo
			Escribir 'Mes incorrecto';
		FinSi
		// Da la opci�n de seguir o salir del programa
		Escribir 'Pulsar la tecla S para continuar ... Gonzalez Pi�on Oscar Zair 501' Sin Saltar;
		Leer seguir;
		Si ((seguir=='S') O (seguir=='s')) Entonces
			S <- Verdadero;
		SiNo
			S <- Falso;
		FinSi
	FinMientras
FinAlgoritmo

// Dibuja la hoja de calendario del mes (month) y a�o (year)
Funcion drawMonth(year,month)
	// Declara las variables:
	// nDM: d�a del mes que toca escribir
	// lDM: �ltimo d�a del mes
	Definir nDM,lDM Como Entero;
	Definir week Como Caracter;
	drawHeader(year,month); // Dibuja la cabecera de la hoja de calendario
	week <- openMonth(year,month); // Dibuja los caracteres anteriores a la primera semana
	nDM <- drawFirstWeek(year,month,week); // Dibuja la primera semana del mes
	lDM <- lastDayMonth(year,month);
	Mientras (lDM-(nDM-1))>=7 Hacer // Mientras queden m�s de 7 d�as
		week <- '';
		nDM <- drawNextWeek(nDM,week); // Dibuja las semanas centrales
	FinMientras
	Si lDM<>(nDM-1) Entonces // Si no ha llegado al �ltimo d�a
		drawLastWeek(nDM,year,month); // Dibuja la �ltima semana
	FinSi
FinFuncion

// Recibe el mes (month) como n�mero y
// devuelve el mismo mes (mT) como texto
Funcion mT <- monthText(month)
	// Declara la variable mT, para contener el texto
	// del mes que corresponda y devolverlo
	Definir mT Como Caracter;
	// Dependiendo del n�mero de mes, se le asigna a mT el texto correspondiente
	Segun month  Hacer
		1:
			mT <- 'ENERO';
		2:
			mT <- 'FEBRERO';
		3:
			mT <- 'MARZO';
		4:
			mT <- 'ABRIL';
		5:
			mT <- 'MAYO';
		6:
			mT <- 'JUNIO';
		7:
			mT <- 'JULIO';
		8:
			mT <- 'AGOSTO';
		9:
			mT <- 'SEPTIEMBRE';
		10:
			mT <- 'OCTUBRE';
		11:
			mT <- 'NOVIEMBRE';
		12:
			mT <- 'DICIEMBRE';
	FinSegun
FinFuncion

// Dibuja la cabecera de la hoja de calendario del mes (month) y a�o (year)
Funcion drawHeader(year,month)
	// Declara la variable line, para controlar
	// el n�mero de caracteres que hay que pintar
	// hasta llegar al a�o
	Definir line Como Entero;
	// Primero un salto de l�nea
	Escribir ' ';
	// Se le asigna a line el n�mero de caracteres
	// que tiene el mes correspondiente
	line <- Longitud(monthText(month));
	// Se escribe el mes en forma de texto
	Escribir monthText(month) Sin Saltar;
	// Hasta sumar 22 se escriben espacios
	Mientras line<=22 Hacer
		Escribir ' ' Sin Saltar;
		line <- line+1;
	FinMientras
	// Se escribe el a�o
	Escribir year;
	// Subrayado doble
	Escribir '===========================';
	// D�as de la semana
	Escribir 'LU  MA  MI  JU  VI | SA  DO';
	// Otro subrayado doble
	Escribir '===========================';
FinFuncion

// Recibe el a�o (year) y devuelve (lY) si es bisiesto o no
Funcion lY <- isLeapYear(year)
	Definir lY Como Logico;
	// Si el a�o es m�ltiplo de 4
	Si (year MOD 4==0) Entonces
		lY <- Verdadero;
		// Si adem�s es m�ltiplo de 100 y de 400
		Si ((year MOD 100<>0) O (year MOD 400==0)) Entonces
			lY <- Verdadero;
		SiNo
			lY <- Falso;
		FinSi
	SiNo
		lY <- Falso;
	FinSi
FinFuncion

// Recibe el a�o (year) correspondiente y
// devuelve el d�a de la semana (dW) en el que cae el primer d�a de dicho a�o
Funcion dW <- firstDayYear(year)
	Definir dW,i Como Entero;
	Definir lY Como Logico;
	Si year==1601 Entonces
		// Si es 1601, el primer d�a del a�o es Lunes
		dW <- 1;
	SiNo
		// Si el a�o es mayor que 1601
		// Buscar primer dia del a�o
		dW <- 1; // Se comienza en lunes
		Para i<-1602 Hasta year Hacer
			// Si el a�o anterior fue bisiesto el d�a de la semana
			// habr� que sumarle dos m�s, y sino uno.
			lY <- isLeapYear(i-1);
			Si lY Entonces
				dW <- dW+2;
			SiNo
				dW <- dW+1;
			FinSi
			// Si se llega a 8, es lunes
			Si dW==8 Entonces
				dW <- 1;
			FinSi
			// Si se llega a 9, es martes
			Si dW==9 Entonces
				dW <- 2;
			FinSi
		FinPara
	FinSi
FinFuncion

// Recibe el a�o (year) y mes (month) correspondientes y
// devuelve el d�a de la semana (dW) en el que cae el primer d�a del mes de ese a�o
Funcion dW <- firstDayMonth(year,month)
	// Declarar variables
	Definir fDY,dW,i Como Entero;
	Definir lY Como Logico;
	lY <- isLeapYear(year); // �Es un a�o bisiesto? 
	fDY <- firstDayYear(year); // Primer d�a de la semana del a�o 
	Para i<-1 Hasta month Hacer
		// Si es enero, el primer d�a ser� el primer d�a del a�o
		Si i==1 Entonces
			dW <- fDY;
		FinSi
		// Si es marzo, el primer d�a depender� de si el a�o es bisiesto o no
		Si i==3 Entonces
			Si lY Entonces
				dW <- dW+1;
			SiNo
				dW <- dW;
			FinSi
		FinSi
		// Si es un mes precedido de otro de 31 d�as, se le sumar�n 3 d�as
		Si (i==2) O (i==4) O (i==6) O (i==8) O (i==9) O (i==11) Entonces
			dW <- dW+3;
		FinSi
		// Si es un mes precedido de otro de 30 d�as, se le sumar�n 2 d�as
		Si (i==5) O (i==7) O (i==10) O (i==12) Entonces
			dW <- dW+2;
		FinSi
		// Si llega a 8, es lunes
		Si dW==8 Entonces
			dW <- 1;
		FinSi
		// Si llega a 9, es martes
		Si dW==9 Entonces
			dW <- 2;
		FinSi
		// Si llega a 10, es mi�rcoles
		Si dW==10 Entonces
			dW <- 3;
		FinSi
	FinPara
FinFuncion

// Dependiendo del d�a de la semana en el 
// que comience el mes, muestra por pantalla
// los caracteres que corresponden
Funcion week <- openMonth(year,month)
	// Declarar dW para guardar en d�a de la semana
	// en el que cae el primer d�a del mes, y la
	// variable week donde guardar los caracteres
	// para empezar la hoja de calendario con 
	// la primera semana
	Definir dW Como Entero;
	Definir week Como Caracter;
	dW <- firstDayMonth(year,month); // Primer d�a del mes	
	// Seg�n el d�a de la semana que sea
	// se pintan los caracteres que corresponden
	Segun dW  Hacer
		2:
			week <- ' .  ';
		3:
			week <- ' .   .  ';
		4:
			week <- ' .   .   .  ';
		5:
			week <- ' .   .   .   .  ';
		6:
			week <- ' .   .   .   .   . | ';
		7:
			week <- ' .   .   .   .   . |  .  ';
	FinSegun
FinFuncion

// Recibe el a�o (year) y el mes (month),
// tambi�n la variable week para seguir 
// guardando la cadena de texto que hay 
// que escribir en la primera semana
Funcion nDM <- drawFirstWeek(year,month,week)
	// Declarar las variables necesarias
	Definir nDM Como Entero; // N�mero del d�a del mes (valor a devolver)
	Definir nDW Como Entero; // D�a de la semana
	Definir i Como Entero; // Contador para recorrer la semana
	nDW <- firstDayMonth(year,month); // D�a de la semana del primer d�a del mes
	nDM <- 1; // D�a 1 del mes	
	Para i<-nDW Hasta 7 Hacer // Hasta que lleguemos al domingo...
		week <- week+' '; // Escribimos un espacio
		week <- week+ConvertirATexto(nDM); // Escribir el n�mero del d�a del mes
		// Sumar 1 al d�a del mes y al d�a de la semana
		nDM <- nDM+1;
		nDW <- nDW+1;
		Si nDW==6 Entonces
			week <- week+' |'; // Si es s�bado
		SiNo
			week <- week+' '; // El resto de d�as
		FinSi
		Si i<>7 Entonces
			week <- week+' '; // Otro espacio
		FinSi
	FinPara
	Escribir week;
FinFuncion

// Recibe el a�o (year) y el mes (month) y 
// devuelve el �ltimo d�a del mes (lDM),
// es decir, el n�mero de d�as del mes
Funcion lDM <- lastDayMonth(year,month)
	// Declarar variables: lY (guarda si es a�o bisiesto),
	// MesDias (para guardar los d�as que deben tener los meses),
	// i (para usarlo de contador y recorrer MesDias)
	// y lDM (para guardar el �ltimo d�a del mes).
	Definir lY Como Logico;
	Definir i Como Entero;
	Dimension MesDias[12];
	Definir MesDias Como Entero;
	Definir lDM Como Entero;
	lY <- isLeapYear(year); // �Es a�o bisiesto?
	Si lY Entonces
		MesDias[2] <- 29; // Si lo es, febrero tiene 29 d�as
	SiNo
		MesDias[2] <- 28;
	FinSi
	// Recorrer MesDias y guardar el n�mero de d�as que tienen el resto de meses
	Para i<-1 Hasta 12 Hacer
		Si (i==4 O i==6 O i==9 O i==11) Entonces
			MesDias[i] <- 30;
		FinSi
		Si (i==1 O i==3 O i==5 O i==7 O i==8 O i==10 O i==12) Entonces
			MesDias[i] <- 31;
		FinSi
	FinPara
	lDM <- MesDias[month]; // El mes (month) tiene (lDM) d�as
FinFuncion

// Recibe el n�mero del d�a del mes (nDM) que toca mostrar por pantalla,
// y la variable week, donde guardar los caracteres a mostrar por pantalla,
// y devuelve, otra vez, el n�mero del d�a del mes (nDM), en el que comienza la semana siguiente.
// Adem�s, pinta las semanas que existen entre la primera y la �ltima semana.
Funcion nDM <- drawNextWeek(nDM,week)
	// Declarar i para usarlo como contador
	Definir i Como Entero;
	// Escribir la semana
	Para i<-1 Hasta 7 Hacer // Del lunes al domingo
		Si nDM<10 Entonces // Si el n�mero del mes es menor de 10
			week <- week+' '; // A�adir un espacio antes del n�mero
		FinSi
		week <- week+ConvertirATexto(nDM); // Escribir el n�mero del d�a del mes
		nDM <- nDM+1; // Sumar 1 al d�a del mes
		Si (i<5 O i==6) Entonces // Si no hemos llegado al viernes o es s�bado
			week <- week+'  '; // Escribir 2 espacios 
		FinSi
		Si i==5 Entonces // Si es viernes
			week <- week+' | '; // Escribir espacio-barra-espacio
		FinSi
	FinPara
	Escribir week; // Pintar la semana
FinFuncion

// Dependiendo del d�a de la semana en el 
// que termine el mes, muestra los caracteres 
// que corresponden. Recibe el d�a de la semanana
// en el que acaba el mes y la variable week, 
// para guardar lo que falta para cerrar
// la hoja del calendario. Adem�s 
// lo muestra por pantalla
Funcion closeMonth(dW,week)
	Segun dW  Hacer
		1:
			week <- week+' .   .   .   . |  .   .';
		2:
			week <- week+' .   .   . |  .   .';
		3:
			week <- week+' .   . |  .   .';
		4:
			week <- week+' . |  .   .';
		5:
			week <- week+' .   .';
		6:
			week <- week+'   .';
	FinSegun
	Escribir week;
FinFuncion

// Recibe como par�metros: el n�mero del d�a del mes (nDM) que toca mostrar por pantalla,
// el a�o (year) y el mes (month). Adem�s, pinta la �ltima semana.
Funcion drawLastWeek(nDM,year,month)
	// Declarar variables: i y j, para utilizar como contadores.
	// Y lDM para guardar el �ltimo d�a del mes.
	Definir i,j Como Entero;
	Definir lDM Como Entero;
	Definir week Como Caracter;
	lDM <- lastDayMonth(year,month); // �ltimo d�a del mes
	j <- (lDM-nDM)+1; // N�mero de d�as que faltan para terminar el mes
	Para i<-1 Hasta j Hacer // Escribir semana
		Si i<7 Entonces
			// Si no ha llegado al domingo
			week <- week+ConvertirATexto(nDM); // Escribir d�a sin hacer salto de l�nea
		FinSi
		nDM <- nDM+1; // Sumar 1 al d�a del mes
		Si (i<5) Entonces // Si no ha llegado al viernes
			week <- week+'  '; // Escribir espacio sin salto de l�nea
		FinSi
		Si i==5 Entonces
			week <- week+' | '; // Si es viernes, espacio-barra-espacio
		FinSi
	FinPara
	closeMonth(j,week); // Cerrar la hoja de calendario con los caracteres que correspondan
FinFuncion