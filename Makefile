FC = gfortran
FFLAGS = -O3

SRCDIR = src
APPDIR = app
TESTDIR = test
BUILDDIR = build
EXEDIR = .

MOD_SRCS = $(wildcard $(SRCDIR)/*.f90)
MAIN_SRC = $(APPDIR)/main.f90
TEST_SRC = $(TESTDIR)/check.f90

MOD_OBJS = $(patsubst $(SRCDIR)/%.f90,$(BUILDDIR)/%.o,$(MOD_SRCS))
MAIN_OBJ = $(BUILDDIR)/main.o
TEST_OBJ = $(BUILDDIR)/check.o

MAIN_EXE = $(EXEDIR)/polyinterp
TEST_EXE = $(EXEDIR)/tests

all: $(MAIN_EXE) $(TEST_EXE)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(BUILDDIR)/%.o: $(SRCDIR)/%.f90 | $(BUILDDIR)
	$(FC) $(FFLAGS) -J$(BUILDDIR) -I$(BUILDDIR) -c $< -o $@

$(MAIN_OBJ): $(MAIN_SRC) | $(BUILDDIR)
	$(FC) $(FFLAGS) -J$(BUILDDIR) -I$(BUILDDIR) -c $< -o $@

$(TEST_OBJ): $(TEST_SRC) | $(BUILDDIR)
	$(FC) $(FFLAGS) -J$(BUILDDIR) -I$(BUILDDIR) -c $< -o $@

$(MAIN_EXE): $(MOD_OBJS) $(MAIN_OBJ)
	$(FC) $(FFLAGS) $^ -o $@

$(TEST_EXE): $(MOD_OBJS) $(TEST_OBJ)
	$(FC) $(FFLAGS) $^ -o $@

$(BUILDDIR)/polynomial_interpolation.o: $(BUILDDIR)/precision_mod.o

$(MAIN_OBJ): $(BUILDDIR)/precision_mod.o $(BUILDDIR)/polynomial_interpolation.o
$(TEST_OBJ): $(BUILDDIR)/precision_mod.o $(BUILDDIR)/polynomial_interpolation.o

chebyshev : $(MAIN_EXE) chebyshev.dat plot_result.plt
	./$(MAIN_EXE) chebyshev
	gnuplot -e "datafile='res_chebyshev.dat'" plot_result.plt

uniform : $(MAIN_EXE) uniform.dat plot_result.plt
	./$(MAIN_EXE) uniform
	gnuplot -e "datafile='res_uniform.dat'" plot_result.plt
.PHONY: all clean chebyshev uniform

clean:
	rm -rf $(BUILDDIR) $(MAIN_EXE) $(TEST_EXE)
