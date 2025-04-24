# Variables
FC ?= gfortran
FFLAGS ?= -g -Wall -pg
#LDFLAGS ?= -pg      # También se necesita para el enlazado


# Archivos fuente
SRC = presicion.f90 hielonn.f90 precipitado.f90 radio0.f90 radio1.f90 radio2.f90 cal_radio.f90 poli_3D_Q.f90

# Nombre del ejecutable
EXEC = fenix

# Regla por defecto
all: $(EXEC)

# Cómo generar el ejecutable directamente desde los archivos .f90
$(EXEC): $(SRC)
	$(FC) $(FFLAGS) $^ -o $@

# Limpiar archivos generados
clean:
	rm -f $(EXEC)
	rm -f gmon.out  
# No eliminar los archivos .mod

# Regla para analizar los datos de perfilado
profile: $(EXEC)
	./$(EXEC)  
	gprof $(EXEC) gmon.out > profile_report.txt  
