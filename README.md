# Diagonalising atomic hydrogen Hamiltonian exercise
This repo is designed to be an exercise of diagaonalising the atomic hydrogen
Hamiltonian. The code is written in Fortran. There are a number of empty 
subroutines in this repo which need to be filled in. Some of the exercises will 
require new subroutines to be written.

**question**: should we include your theoretical background pdf in this repo 
@liam to point the students to in the README?

## Table of Contents
- [Installation](#installation)
- [Exercises](#exercises)
- [Compilation](#compilation)
- [Basic Usage](#basic-usage)

## Installation
To install this code please enter the following command

```bash
git clone <fill-in-when-apart-of-itp-org>
```

## Exercises

1. Fill in subroutine `generate_sturmian_basis` in `src/sturmian.f90` to 
   generate the radial Sturmian functions. Create a new subroutine which is 
   called in generate_sturmian_basis to output the generated Sturmian functions 
   to a file. Compare with correct results in `solutions/basis/` to check your
   implementation is correct.

   BONUS: Implement a switch to turn on and off printing these functions to file

2. Fill in the subroutine `generate_overlap_matrix` in 
   `src/matrix_elements.f90` to calculate the overlap matrix elements.

3. Fill in the subroutine `generate_hamiltonian_matrix` in 
   `src/matrix_elements.f90` to generate the Hamiltonian matrix for atomic 
    hydrogen.

4. Starting with l=0 orbital angular momentum and scale parameter 
   $\zeta = 1$, run the program with basis sizes of 5, 10, 20, 30, and 50. In
   each case how many solutions agree with the exact energy eigenvalues of
   atomic hydrogen.

5. Test the program for states with different $l$ to ensure that the
   implementation is correct for not just $s$-states.

6. For a fixed basis size of 30, vary the scale parameter $\zeta$ and see how it 
   affects the accuracy of the results and the distribution of the pseudostates.
   What happens if you decrease/increase $\zeta$? 

7. Create a new module/subroutines to print the radial wavefunctions 
   $u_{n,l}(r)$ to a file. Compare with analytic results in 
   `solutions/wavefunctions/` to check your implementation is correct.

8. Alter the input file parser and the Hamiltonian matrix elements, to allow 
   for different nuclear charges $Z$ to be specified. Does the optimial value 
   of $\zeta$ for the $1s$ state change as you change $Z$?

## Compilation
To compile this code, you will need to have a Fortran compiler and LAPACK
library installed on your machine. If on a Linux-based system (or running WSL on
Windows), you can install these by running the following command in the terminal:

```bash
sudo apt update
sudo apt install gfortran liblapack-dev
```

If you are on a mac OS system, you can install these using Homebrew by running
the following command in the terminal:

```bash
brew install gfortran lapack
```

You will also need to have pulled the fortran parser library `fparse` from
GitHub and installed it on your machine. Inside the repo directory, you can run
the following command to pull the library:

```bash
git submodule update --init --recursive
```

Next, to compile the code, you need to first change into the `compile/` 
directory. Once there, you can run the following make command:

```bash
make
```

This will create an directory outside the `compile/` directory called
`build/` which will contain the final executable `h_diagonalisation.exe` and 
as well as all the object and module files generated during the compilation 
process.

### Debug build
To compile the code with debug flags enabled, you can run the following command
in the `compile/` directory:

```bash
make debug=on
```

## Basic Usage
To run the program, you can copy the example working directory `example/`
outside of the repo and change into it. Once there, you need to update the
`run.sh` script to update the `REPO_PATH` variable to store the location of
the repo on your machine. Once that is done, you can edit the `data.in` file to
specify the parameters of your calculation, and then run the `run.sh` script by
typing the following command in the terminal:

```bash
./run.sh
```
