# Examen Práctico Integrador de C++ - Grupo H

**Asignatura:** Algoritmos de Programación / Programación en C++ 
**Caso Asignado:** Grupo H - Parqueadero universitario y control de infracciones 

## 1. Descripción del Proyecto
Este repositorio contiene la solución al examen práctico integrador desarrollado en C++. [cite_start]El sistema gestiona el parqueadero de un campus universitario, controlando los ingresos, salidas, tiempos de permanencia, tarifas y sanciones de los vehículos[cite: 164]. [cite_start]Además, el proyecto integra un módulo obligatorio del juego "Ahorcado", adaptado al vocabulario técnico del caso principal[cite: 51, 64].

## 2. Metodología de Desarrollo 
El proyecto fue construido siguiendo un enfoque estructurado de 6 fases, evidenciando un proceso de desarrollo real[cite: 21, 28]:

* **Fase 1 - Análisis:** Se identificaron las entidades principales, reglas de negocio (como el cálculo de tarifas e infracciones) y se elaboró una prueba de escritorio mínima.
* **Fase 2 - Diseño:** Se definieron las clases requeridas con sus respectivos atributos privados y métodos, además de estructurar el menú principal integrador.
* **Fase 3 - Construcción incremental:** Se programó primero la base del sistema y validaciones, luego el registro de vehículos, las búsquedas/ordenamientos manuales, la recursividad y, por último, el módulo del Ahorcado.
* **Fase 4 - Pruebas y depuración:** Se ejecutaron casos normales y límite, validando que el programa no termine por datos inválidos, y se corrigió el fragmento de código defectuoso asignado.
* **Fase 5 - Versionamiento:** El desarrollo se respaldó utilizando GitHub Desktop para Windows, realizando commits significativos en cada avance importante.
* **Fase 6 - Cierre:** Preparación del código compilable, este archivo README, y listos para la defensa técnica.

## 3. Estructura y Partes Implementadas 

El sistema cumple con los requisitos técnicos obligatorios:
* **Clases Principales:** Se implementaron las clases `VehiculoCampus` y `RegistroParqueo`, aplicando encapsulamiento completo y constructores.
* **Registros:** Ingreso de vehículos (placa, propietario, tipo, carrera) y control de entradas/salidas (hora, bloque, espacio asignado).
* **Lógica de Negocio:** Cálculo automático de tiempo de permanencia, aplicación de tarifas o gratuidad según el usuario, y detección de exceso de tiempo.
* **Búsqueda y Ordenamiento Manual:** Algoritmos creados desde cero para buscar por placa o propietario, y para ordenar los registros por mayor ocupación y mayor número de infracciones.
* **Recursividad:** Se aplicó una función recursiva con utilidad real dentro del cálculo de datos del sistema.

## 4. Módulo Integrado de Ahorcado
Se desarrolló un juego de Ahorcado funcional accesible desde el menú principal.
* **Adaptación al Dominio:** Las palabras a adivinar están estrictamente relacionadas con el contexto del parqueadero: placas simbólicas, nombres de bloques, tipos de vehículos e infracciones frecuentes.
* **Características:** Cuenta con niveles de dificultad, validación de letras (sin caracteres inválidos o repetidos), sistema de puntuación, historial de partidas y muestra el avance visual de la palabra y los intentos restantes.

## 5. Depuración de Código (Fragmento Asignado) 
Durante el desarrollo se identificó y corrigió un error lógico en la función `calcularHoras`.
**Código original defectuoso:**
```cpp
int calcularHoras(int entrada, int salida){
    int horas = salida - entrada;
    if(horas = 0) // ERROR: Operador de asignación en lugar de comparación
        return 1;
    return horas;
}
