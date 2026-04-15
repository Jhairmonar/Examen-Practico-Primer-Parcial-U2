Proceso SistemaControlZonaUTA
    // Configuración inicial (Simulación de constantes globales)
    Definir MAX_VEHICULOS Como Entero
    Definir TARIFA_HORA Como Real
    MAX_VEHICULOS <- 50
    TARIFA_HORA <- 1.50
    
    // Arreglos paralelos (Simulan la clase VehiculoCampus)
    Definir placas, propietarios, tipos, departamentos Como Caracter
    Definir horasPermanencia, infracciones Como Entero
    Dimension placas[50], propietarios[50], tipos[50], departamentos[50]
    Dimension horasPermanencia[50], infracciones[50]
    
    Definir totalRegistrados, opc Como Entero
	totalRegistrados <- 0
	opc <- 0
    
    // Variables temporales para el Menú
    Definir p, pr, t, d, placaMov, placaBuscada Como Caracter
    Definir entrada, salida, horasCalculadas, indice, totales, i Como Entero
    Definir aPagar Como Real
    
    Repetir
        Escribir ""
        Escribir "=========================================="
        Escribir "   SISTEMA DE CONTROL DE ZONA UTA (GRUPO H)  "
        Escribir "=========================================="
        Escribir "1. Registrar nueva unidad (Vehiculo)"
        Escribir "2. Registrar movimiento (Ingreso/Salida)"
        Escribir "3. Rastreo por Placa (Busqueda)"
        Escribir "4. Reporte de Hostiles (Ordenar por Infracciones)"
        Escribir "5. Resumen del Perimetro (Infracciones Totales - Recursividad)"
        Escribir "6. Modulo de Ahorcado"
        Escribir "7. Desconectar"
        Escribir "Seleccione una opcion: " Sin Saltar
        Leer opcion
        
        Si opcion == 1 Entonces
            Si totalRegistrados < MAX_VEHICULOS Entonces
                // Nota en PSeInt los arreglos inician en 1 (por defecto en perfil estricto)
                totalRegistrados <- totalRegistrados + 1
                
                Escribir "Placa del vehiculo (Ej: AAA123): " Sin Saltar
                Leer p
                Escribir "Nombre del propietario (Un nombre): " Sin Saltar
                Leer pr
                Escribir "Tipo (Auto/Moto): " Sin Saltar
                Leer t
                Escribir "Departamento/Carrera: " Sin Saltar
                Leer d
                
                placas[totalRegistrados] <- p
                propietarios[totalRegistrados] <- pr
                tipos[totalRegistrados] <- t
                departamentos[totalRegistrados] <- d
                horasPermanencia[totalRegistrados] <- 0
                infracciones[totalRegistrados] <- 0
                
                Escribir "[+] Unidad registrada exitosamente."
            Sino
                Escribir "[!] Capacidad de zona al maximo."
            FinSi
            
        SiNo Si opcion == 2 Entonces
				Escribir "Ingrese placa para el registro de horas: " Sin Saltar
				Leer placaMov
				
				// PSeInt tiene la función Mayusculas() que reemplaza el ciclo ASCII manual de C++
				placaMov <- Mayusculas(placaMov)
				
				indice <- buscarVehiculo(placas, totalRegistrados, placaMov)
				
				Si indice <> -1 Entonces
					Escribir "Hora de entrada (Formato 24h, ej: 8): " Sin Saltar
					Leer entrada
					Escribir "Hora de salida (Formato 24h, ej: 12): " Sin Saltar
					Leer salida
					
					horasCalculadas <- calcularHoras(entrada, salida)
					horasPermanencia[indice] <- horasPermanencia[indice] + horasCalculadas
					
					aPagar <- horasCalculadas * TARIFA_HORA
					Escribir "[+] Movimiento registrado. Permanencia: ", horasCalculadas, "h. Tarifa: $", aPagar
					
					Si horasCalculadas > 8 Entonces
						infracciones[indice] <- infracciones[indice] + 1
						Escribir "[!] ALERTA: Exceso de permanencia detectado. Infraccion asignada."
					FinSi
				Sino
					Escribir "[-] Objetivo no encontrado en el radar."
				FinSi
				
			SiNo Si opcion == 3 Entonces
					Escribir "Placa a interceptar: " Sin Saltar
					Leer placaBuscada
					placaBuscada <- Mayusculas(placaBuscada)
					
					indice <- buscarVehiculo(placas, totalRegistrados, placaBuscada)
					
					Si indice <> -1 Entonces
						Escribir "\n--- DATOS DE LA UNIDAD ---"
						Escribir "Placa: ", placas[indice], " | Propietario: ", propietarios[indice], " | Tipo: ", tipos[indice], " | Depto: ", departamentos[indice], " | Horas: ", horasPermanencia[indice], " | Infracciones: ", infracciones[indice]
					Sino
						Escribir "[-] Objetivo evasivo. No encontrado."
					FinSi
					
				SiNo Si opcion == 4 Entonces
						Si totalRegistrados > 0 Entonces
							ordenarPorInfracciones(placas, propietarios, tipos, departamentos, horasPermanencia, infracciones, totalRegistrados)
							Para i <- 1 Hasta totalRegistrados Hacer
								Escribir "Placa: ", placas[i], " | Propietario: ", propietarios[i], " | Tipo: ", tipos[i], " | Depto: ", departamentos[i], " | Horas: ", horasPermanencia[i], " | Infracciones: ", infracciones[i]
							FinPara
						Sino
							Escribir "[-] No hay registros en el perimetro."
						FinSi
						
					SiNo Si opcion == 5 Entonces
							totales <- totalInfraccionesSect(infracciones, totalRegistrados)
							Escribir "\n[REPORTE TACTICO] Infracciones totales en el campus: ", totales
							
						SiNo Si opcion == 6 Entonces
								ejecutarAhorcado()
							FinSi
						FinSi
					FinSi
				FinSi
			FinSi
        FinSi
        
    Hasta Que opcion == 7
    
    Escribir "\n[!] Sistema desconectado. Fin de la transmision."
FinProceso

// ==========================================
// FUNCIONES Y SUBPROCESOS
// ==========================================

Funcion horas <- calcularHoras(entrada, salida)
    Definir horas Como Entero
    horas <- salida - entrada
    Si horas == 0 Entonces
        horas <- 1
    FinSi
FinFuncion

// Función RECURSIVA para sumar infracciones
Funcion total <- totalInfraccionesSect(infracciones, n)
    Definir total Como Entero
    Si n <= 0 Entonces
        total <- 0
    Sino
        total <- infracciones[n] + totalInfraccionesSect(infracciones, n - 1)
    FinSi
FinFuncion

// Búsqueda Secuencial
Funcion indice <- buscarVehiculo(placas, n, placaBuscada)
    Definir indice, i Como Entero
    indice <- -1
    Para i <- 1 Hasta n Hacer
        Si placas[i] == placaBuscada Entonces
            indice <- i
            i <- n // Romper el ciclo simulado
        FinSi
    FinPara
FinFuncion

// Ordenamiento Burbuja Adaptado a Arreglos Paralelos
SubProceso ordenarPorInfracciones(placas Por Referencia, propietarios Por Referencia, tipos Por Referencia, departamentos Por Referencia, horasPermanencia Por Referencia, infracciones Por Referencia, n)
    Definir i, j Como Entero
    Definir tempStr Como Caracter
    Definir tempInt Como Entero
    
    Para i <- 1 Hasta n - 1 Hacer
        Para j <- 1 Hasta n - i Hacer
            Si infracciones[j] < infracciones[j + 1] Entonces
                // Intercambio de Infracciones
                tempInt <- infracciones[j]
                infracciones[j] <- infracciones[j + 1]
                infracciones[j + 1] <- tempInt
                
                // Intercambio de Horas
                tempInt <- horasPermanencia[j]
                horasPermanencia[j] <- horasPermanencia[j + 1]
                horasPermanencia[j + 1] <- tempInt
                
                // Intercambio de Placas
                tempStr <- placas[j]
                placas[j] <- placas[j + 1]
                placas[j + 1] <- tempStr
                
                // Intercambio de Propietarios
                tempStr <- propietarios[j]
                propietarios[j] <- propietarios[j + 1]
                propietarios[j + 1] <- tempStr
                
                // Intercambio de Tipos
                tempStr <- tipos[j]
                tipos[j] <- tipos[j + 1]
                tipos[j + 1] <- tempStr
                
                // Intercambio de Departamentos
                tempStr <- departamentos[j]
                departamentos[j] <- departamentos[j + 1]
                departamentos[j + 1] <- tempStr
            FinSi
        FinPara
    FinPara
    Escribir "\n[!] Reordenamiento completado. Listando hostiles primero...\n"
FinSubProceso

// Módulo de Juego Ahorcado
SubProceso ejecutarAhorcado
    Definir palabraOculta, progreso, letra, nuevoProgreso Como Caracter
    Definir intentos, i Como Entero
    Definir victoria, acierto Como Logico
    
    palabraOculta <- "INFRACCION"
    progreso <- "__________"
    intentos <- 6
    victoria <- Falso
    
    Escribir "\n======================================="
    Escribir "   MODULO DE ENTRENAMIENTO: AHORCADO"
    Escribir "======================================="
    Escribir "Mision: Descifrar el codigo del objetivo."
    
    Mientras intentos > 0 Y NO victoria Hacer
        Escribir "\nEstado actual: ", progreso
        Escribir "Vidas restantes: ", intentos
        Escribir "Ingrese una letra: " Sin Saltar
        Leer letra
        
        letra <- Mayusculas(letra)
        acierto <- Falso
        nuevoProgreso <- ""
        
        // Reconstrucción del string (PSeInt no permite progreso[i] = letra directamente)
        Para i <- 1 Hasta Longitud(palabraOculta) Hacer
            Si Subcadena(palabraOculta, i, i) == letra Y Subcadena(progreso, i, i) == "_" Entonces
                nuevoProgreso <- nuevoProgreso + letra
                acierto <- Verdadero
            Sino
                nuevoProgreso <- nuevoProgreso + Subcadena(progreso, i, i)
            FinSi
        FinPara
        
        progreso <- nuevoProgreso
        
        Si NO acierto Entonces
            intentos <- intentos - 1
            Escribir "[-] Letra incorrecta. Recibiendo dano."
        Sino
            Escribir "[+] Acierto confirmado."
        FinSi
        
        Si progreso == palabraOculta Entonces
            victoria <- Verdadero
        FinSi
    FinMientras
    
    Si victoria Entonces
        Escribir "\n[VICTORIA] Codigo descifrado: ", palabraOculta, ". Mision cumplida."
    Sino
        Escribir "\n[DERROTA] Intentos agotados. La palabra era: ", palabraOculta
    FinSi
FinSubProceso