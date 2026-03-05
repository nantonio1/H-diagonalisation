
#------------------------------------------------------------------------------
# directories (relative to the compile directory)
#------------------------------------------------------------------------------
SRC_DIR    = ../src
BUILD_DIR  = ../build
OBJ_DIR    = $(BUILD_DIR)/obj
MOD_DIR    = $(BUILD_DIR)/mod
FPARSE_SRC_DIR = ../external/fparse/src

#------------------------------------------------------------------------------
# set compiler
#------------------------------------------------------------------------------
FC = gfortran

#------------------------------------------------------------------------------
# set flags
#------------------------------------------------------------------------------
# will always need this apart of the flags
FC_MODULE_DIR_FLAG ?= -J$(MOD_DIR)
FC_LINE_LENGTH_FLAG ?= -ffree-line-length-none
FCFLAGS  = $(FC_MODULE_DIR_FLAG) -I$(MOD_DIR) $(FC_LINE_LENGTH_FLAG)

FC_DEBUG = -g -O0
FC_PROD  = -O3 

# debugging checks
ifeq ($(debug), on)
	FCFLAGS += $(FC_DEBUG)
	LDFLAGS += $(FC_DEBUG)
else
	FCFLAGS += $(FC_PROD)
	LDFLAGS += $(FC_PROD)
endif


#------------------------------------------------------------------------------
# list of source files
#------------------------------------------------------------------------------
SOURCES = precision_mod.f90 \
		  rgrid.f90 \
		  basis.f90 \
		  sturmian.f90 \
		  basis_setup.f90 \
		  main.f90 \


#------------------------------------------------------------------------------
# list of source files for fparse (fortran input file parser)
#------------------------------------------------------------------------------
FPARSE_SOURCES = fparse_types.f90 \
		         fparse_util.f90 \
		         fparse_schema.f90 \
		         fparse_io.f90 \
		         fparse_parser.f90 \
		         fparse_getters.f90 \
		         fparse.f90

# name of final executable
TARGET = $(BUILD_DIR)/h_diagonalisation.exe

#------------------------------------------------------------------------------
# object files
#------------------------------------------------------------------------------
OBJECTS = $(patsubst %.f90, $(OBJ_DIR)/%.o, $(SOURCES))
FPARSE_OBJECTS = $(patsubst %.f90, $(OBJ_DIR)/%.o, $(FPARSE_SOURCES))

OBJS = $(OBJECTS) $(FPARSE_OBJECTS)

# default target
all: $(BUILD_DIR) $(OBJ_DIR) $(MOD_DIR) $(TARGET)

# create build directories if they do not exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(MOD_DIR):
	mkdir -p $(MOD_DIR)

# pattern rule for compiling fparse .f90 files:
$(OBJ_DIR)/fparse_%.o: $(FPARSE_SRC_DIR)/%.f90
	$(FC) $(FCFLAGS) -c $< -o $@

# pattern rule for compiling .f90 files:
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.f90
	$(FC) $(FCFLAGS) -c $< -o $@

# Link all object files to create the final cs-ccc executable
$(TARGET): $(OBJS)
	$(FC) $(FPARSE_OBJS) $(OBJS_F90) $(OBJS_F) -L$(OBJ_DIR) $(LDFLAGS) -o $(TARGET)

# clean up the build directory
clean:
	rm -rf $(BUILD_DIR)/*

