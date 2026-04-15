#include <iostream>
#include <string>
using namespace std;

// Constantes globales de operación 
const int MAX_VEHICULOS = 50;
const double TARIFA_HORA = 1.50;

// ==========================================
// CLASE 1: VehiculoCampus
// ==========================================
class VehiculoCampus {
private:
    string placa;
    string propietario;
    string tipo; 
    string departamento;
    int horasPermanencia;
    int infracciones;

public:
    // Constructor: Inicializa la unidad en la base de datos
    VehiculoCampus(string p = "", string prop = "", string t = "", string dep = "") {
        placa = p;
        propietario = prop;
        tipo = t;
        departamento = dep;
        horasPermanencia = 0;
        infracciones = 0;
    }

    // Getters: Extracción de datos clasificados
    string getPlaca() { return placa; }
    string getPropietario() { return propietario; }
    int getHorasPermanencia() { return horasPermanencia; }
    int getInfracciones() { return infracciones; }

    // Setters y métodos de actualización operativa
    void registrarMovimiento(int horas) {
        horasPermanencia += horas;
    }

    void reportarInfraccion() {
        infracciones++;
    }

    // Visualización del estado actual de la unidad
    void mostrarDatos() {
        cout << "Placa: " << placa << " | Propietario: " << propietario 
             << " | Tipo: " << tipo << " | Depto: " << departamento 
             << " | Horas: " << horasPermanencia << " | Infracciones: " << infracciones << endl;
    }
};


// Depuración del fragmento asignado (Grupo H)
// Corrección táctica: Uso de '==' para comparación en lugar de '=' (asignación)
int calcularHoras(int entrada, int salida) {
    int horas = salida - entrada;
    if (horas == 0) {
        return 1; // Tarifa mínima por despliegue corto
    }
    return horas;
}

// Función RECURSIVA: Calcula el impacto total (suma de infracciones) en el perímetro
int totalInfraccionesSect(VehiculoCampus vehiculos[], int n) {
    if (n <= 0) return 0; // Caso base: Fin del barrido
    return vehiculos[n - 1].getInfracciones() + totalInfraccionesSect(vehiculos, n - 1);
}

// Ordenamiento manual: Táctica de "Burbuja" para listar mayores infractores (Sin usar sort)
void ordenarPorInfracciones(VehiculoCampus vehiculos[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (vehiculos[j].getInfracciones() < vehiculos[j + 1].getInfracciones()) {
                // Intercambio de posiciones
                VehiculoCampus temp = vehiculos[j];
                vehiculos[j] = vehiculos[j + 1];
                vehiculos[j + 1] = temp;
            }
        }
    }
    cout << "\n[!] Reordenamiento completado. Listando hostiles primero...\n";
}

// Búsqueda manual: Rastreo secuencial por placa
int buscarVehiculo(VehiculoCampus vehiculos[], int n, string placaBuscada) {
    for (int i = 0; i < n; i++) {
        if (vehiculos[i].getPlaca() == placaBuscada) {
            return i; // Objetivo localizado
        }
    }
    return -1; // Objetivo no encontrado
}

// ==========================================
// MÓDULO OBLIGATORIO: ENTRENAMIENTO (AHORCADO)
// ==========================================
void ejecutarAhorcado() {
    cout << "\n=======================================\n";
    cout << "   MODULO DE ENTRENAMIENTO: AHORCADO\n";
    cout << "=======================================\n";
    
    // Vocabulario restringido al dominio del Grupo H (Parqueadero)
    string palabraOculta = "INFRACCION"; 
    string progreso = "__________";
    int intentos = 6;
    bool victoria = false;
    char letra;

    cout << "Mision: Descifrar el codigo del objetivo.\n";
    
    while (intentos > 0 && !victoria) {
        cout << "\nEstado actual: " << progreso << "\n";
        cout << "Vidas restantes: " << intentos << "\n";
        cout << "Ingrese una letra: ";
        cin >> letra;

        // CONVERSIÓN MANUAL A MAYÚSCULA (Lógica ASCII)
        if (letra >= 'a' && letra <= 'z') {
            letra = letra - 32; 
        }

        bool acierto = false;
        for (int i = 0; i < palabraOculta.length(); i++) {
            if (palabraOculta[i] == letra && progreso[i] == '_') {
                progreso[i] = letra;
                acierto = true;
            }
        }

        if (!acierto) {
            intentos--;
            cout << "[-] Letra incorrecta. Recibiendo dano.\n";
        } else {
            cout << "[+] Acierto confirmado.\n";
        }

        if (progreso == palabraOculta) {
            victoria = true;
        }
    }

    if (victoria) {
        cout << "\n[VICTORIA] Codigo descifrado: " << palabraOculta << ". Mision cumplida.\n";
    } else {
        cout << "\n[DERROTA] Intentos agotados. La palabra era: " << palabraOculta << "\n";
    }
}

// ==========================================
// CENTRO DE MANDO
// ==========================================
int main() {
    VehiculoCampus baseDatos[MAX_VEHICULOS];
    int totalRegistrados = 0;
    int opcion;

    do {
        cout << "\n==========================================\n";
        cout << "   SISTEMA DE CONTROL DE ZONA UTA (GRUPO H)  \n";
        cout << "==========================================\n";
        cout << "1. Registrar nueva unidad (Vehiculo)\n";
        cout << "2. Registrar movimiento (Ingreso/Salida)\n";
        cout << "3. Rastreo por Placa (Busqueda)\n";
        cout << "4. Reporte de Hostiles (Ordenar por Infracciones)\n";
        cout << "5. Resumen del Perimetro (Infracciones Totales - Recursividad)\n";
        cout << "6. Modulo de Ahorcado\n";
        cout << "7. Desconectar\n";
        cout << "Seleccione una opcion: ";
        cin >> opcion;

        if (opcion == 1) {
            if (totalRegistrados < MAX_VEHICULOS) {
                string p, pr, t, d;
                cout << "Placa del vehiculo (Ej: AAA123): "; cin >> p;
                cout << "Nombre del propietario (Un nombre): "; cin >> pr;
                cout << "Tipo (Auto/Moto): "; cin >> t;
                cout << "Departamento/Carrera: "; cin >> d;
                
                baseDatos[totalRegistrados] = VehiculoCampus(p, pr, t, d);
                totalRegistrados++;
                cout << "[+] Unidad registrada exitosamente.\n";
            } else {
                cout << "[!] Capacidad de zona al maximo.\n";
            }
        } 
        else if (opcion == 2) {
            string placaMov;
            cout << "Ingrese placa para el registro de horas: "; cin >> placaMov;
            
            // CONVERSIÓN MANUAL A MAYÚSCULAS PARA LA PLACA INGRESADA
            for (int i = 0; i < placaMov.length(); i++) {
                if (placaMov[i] >= 'a' && placaMov[i] <= 'z') {
                    placaMov[i] = placaMov[i] - 32;
                }
            }

            int indice = buscarVehiculo(baseDatos, totalRegistrados, placaMov);
            
            if (indice != -1) {
                int entrada, salida;
                cout << "Hora de entrada (Formato 24h, ej: 8): "; cin >> entrada;
                cout << "Hora de salida (Formato 24h, ej: 12): "; cin >> salida;
                
                int horasCalculadas = calcularHoras(entrada, salida);
                baseDatos[indice].registrarMovimiento(horasCalculadas);
                
                double aPagar = horasCalculadas * TARIFA_HORA;
                cout << "[+] Movimiento registrado. Permanencia: " << horasCalculadas << "h. Tarifa: $" << aPagar << "\n";
                
                if (horasCalculadas > 8) {
                    baseDatos[indice].reportarInfraccion();
                    cout << "[!] ALERTA: Exceso de permanencia detectado. Infraccion asignada al objetivo.\n";
                }
            } else {
                cout << "[-] Objetivo no encontrado en el radar.\n";
            }
        }
        else if (opcion == 3) {
            string placaBuscada;
            cout << "Placa a interceptar: "; cin >> placaBuscada;
            
            // CONVERSIÓN MANUAL A MAYÚSCULAS PARA LA BÚSQUEDA
            for (int i = 0; i < placaBuscada.length(); i++) {
                if (placaBuscada[i] >= 'a' && placaBuscada[i] <= 'z') {
                    placaBuscada[i] = placaBuscada[i] - 32;
                }
            }

            int indice = buscarVehiculo(baseDatos, totalRegistrados, placaBuscada);
            if (indice != -1) {
                cout << "\n--- DATOS DE LA UNIDAD ---\n";
                baseDatos[indice].mostrarDatos();
            } else {
                cout << "[-] Objetivo evasivo. No encontrado.\n";
            }
        }
        else if (opcion == 4) {
            if (totalRegistrados > 0) {
                ordenarPorInfracciones(baseDatos, totalRegistrados);
                for (int i = 0; i < totalRegistrados; i++) {
                    baseDatos[i].mostrarDatos();
                }
            } else {
                cout << "[-] No hay registros en el perimetro.\n";
            }
        }
        else if (opcion == 5) {
            int totales = totalInfraccionesSect(baseDatos, totalRegistrados);
            cout << "\n[REPORTE TACTICO] Infracciones totales en el campus: " << totales << "\n";
        }
        else if (opcion == 6) {
            ejecutarAhorcado();
        }

    } while (opcion != 7);

    cout << "\n[!] Sistema desconectado. Fin de la transmision.\n";
    return 0;
}