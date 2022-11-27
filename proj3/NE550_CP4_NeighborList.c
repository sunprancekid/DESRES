// Program taken from code sourced by Dr. Jacob Eapan, "Introduction to Atomistic Simulations" NE 550
// Adapted by Matthew Dorsey
// Department of Chemical and Biomolecular Engineering


// Call libraries
#include <stdlib.h>
#include <math.h>
#include <stdio.h>

// Function prototypes //
void SetParams(); 
void SetupJob();
void AllocArrays();
void InitCoords();
void InitVels();
void InitAccels();
void InitDiffusion();
void ZeroDiffusion();
double VRand();
double RandR();
void AccumProps();
void SingleStep();
void BuildNebrList();
void ApplyBoundaryConditions();
void ComputeForces();
void LeapfrogStep();
void AdjustTemp();
void EvalProps();
void EvalRdf();
void EvalLatticeCorr();
void EvalDiffusion();
void AccumDiffusion();
void PrintSummary();
void PrintRdf();
void PrintDiffusion();


// MACRO Definitions //

// Add two vectors v2 and v3 in 3D
#define VAdd(v1, v2, v3) \
(v1).x = (v2).x + (v3).x, \
(v1).y = (v2).y + (v3).y, \
(v1).z = (v2).z + (v3).z

// Subtract two vectors v2 and v3 in 3D
#define VSub(v1, v2, v3)\
(v1).x = (v2).x - (v3).x, \
(v1).y = (v2).y - (v3).y, \
(v1).z = (v2).z - (v3).z

// Take the dot product of two vectors v1 and v2 in 2D
#define VDot(v1, v2)\
((v1).x * (v2).x + (v1).y * (v2).y + (v1).z * (v2).z)

// Multiply 3D components of two vectors
#define VMul(v1, v2, v3) \
(v1).x = (v2).x * (v3).x, \
(v1).y = (v2).y * (v3).y, \
(v1).z = (v2).z * (v3).z

// Divide two 3D vector quantities by one another
#define VDiv(v1, v2, v3) \
(v1).x = (v2).x / (v3).x, \
(v1).y = (v2).y / (v3).y, \
(v1).z = (v2).z / (v3).z

// Add two vectors v2 and v3, one multiplied by a scalar quantity
#define VSAdd(v1, v2, s3, v3) \
(v1).x = (v2).x + (s3) * (v3).x, \
(v1).y = (v2).y + (s3) * (v3).y, \
(v1).z = (v2).z + (s3) * (v3).z

// Add 3D vector components to a running sum
#define VVAdd(v1, v2) \
(v1).x = (v1).x + (v2).x, \
(v1).y = (v1).y + (v2).y, \
(v1).z = (v1).z + (v2).z

// Sets values for the components of vector v
#define VSet(v, sx, sy, sz) \
(v).x = sx, \
(v).y = sy, \
(v).z = sz

#define VSetAll(v, s) VSet (v, s, s, s)
#define VZero(v) VSetAll (v, 0)
#define VVSAdd(v1, s2, v2) VSAdd (v1, v1, s2, v2) 
#define VLenSq(v) VDot(v, v)

//Perform a wraparound operation (minimum image convention)
#define VWrap(v, t) \
if (v.t >= 0.5 * region.t) v.t -= region.t; \
else if (v.t < -0.5 * region.t) v.t += region.t

// Apply PBC check to each dimension of position vector
#define VWrapAll(v) \
{VWrap (v, x); \
VWrap (v, y); \
VWrap (v,z);}

#define Sqr(x) ((x) * (x)) // Square scalar value ‘x’
#define Cube(x) ((x) * (x) * (x)) // Cube scalar value 'x'
#define DO_MOL for (n = 0; n < nMol; n ++) // Loop through all atoms 'n'

// Multiply 3D components of vector v by scalar s
#define VScale(v, s) \
(v).x *= s, \
(v).y *= s, \
(v).z *= s

// If this MACRO gives the debugger problems, change commma to semicolan
#define VSCopy(v2, s1, v1) \
(v2).x = (s1) * (v1).x, \
(v2).y = (s1) * (v1).y, \
(v2).z = (s1) * (v1).z

#define VProd(v) ((v).x * (v).y * (v).z)

// zero all elements of ‘Prop’ vector elements ‘sum’ and ‘sum2’
#define PropZero(v) \
(v).sum = 0., \
(v).sum2 = 0., \
(v).fluc = 0.

// Keep running sum of Prop and Prop^2 vector elements
#define PropAccum(v) \
(v).sum += (v).val, \
(v).sum2 += Sqr ((v).val), \
(v).fluc += Sqr ((v).val) 

// Compute average value of Prop vector and its standard deviation
#define PropAvg(v, n) \
(v).sum /= n, \
(v).sum2 = sqrt (Max ((v).sum2 / n - Sqr ((v).sum), 0.)), \
(v).fluc = ((v).fluc / n) - Sqr( (v).sum )  // Max test eliminates rounding errors when result is close to zero

// Used to print system properties (will be updated in subsequent values)
#define PropEst(v) \
(v).sum, (v).sum2, (v).fluc

// Test: If x1 is greater than x2, take x1, otherwise take x1
#define Max(x1, x2) \
(((x1) > (x2)) ? (x1) : (x2))

#define VCSum(v) ((v).x + (v).y + (v).z)

// number of dimensions
#define NDIM 3

#define AllocMem(a, n, t) a = (t*) malloc((n) * sizeof(t))

// Values used for random number genorater
#define IADD 453806245
#define IMUL 314159269
#define MASK 2147483647
#define SCALE 0.4656612873e-9


// Structures //
typedef double real; // creates double precision data type called 'real'

typedef struct { // defines a C structure type
    double x, y, z;
} VecR; // creates a 2D structure called VecR

typedef struct { 
    VecR r, rv, ra; // creates 2D vector quantities r, rv, ra
} Mol; // Array that stores the coordinates, velocities, and acceleration of each atom;

//creates a vector called ‘Prop’ for computing system properties such as pressure
typedef struct {
double val, sum, sum2, fluc;
} Prop; 

// creates a new data structure 'Vecl' that will be used in assigning an array of unit cells
typedef struct{
    int x, y, z;
} VecI; 

// creates a new structure TBuf used to created buffers for measuring diffusion
typedef struct {
    VecR *orgR, *rTrue;
    double *rrDiffuse;
    int count;
} TBuf;


// Global Variables //
Mol *mol; // creates a variable mol that points to the Mol data structure
VecR region, vSum; // vector quantities region (edge length of simulation region)
VecI initUcell; // vector quantitity initUcell (initial no. of unit cells)
Prop kinEnergy, totEnergy, pressure, potEnergy, momentum, potEnergyFluc, kinEnergyFluc, totEnergyFluc;
double deltaT, denisty, rCut, timeNow, uSum, virSum, density, VelMag;
int nMol, moreCycles, stepCount, Count;

//Global variables required for the Neighbor List method
real dispHi, rNebrShell = 0.4;
int *nebrTab, nebrNow, nebrTabFac, nebrTabLen, nebrTabMax;

//Global Variables required for the Radial Distribution Function and Lattice Correlation Function
double *histRdf, deltaR, latticeCorr, rangeRdf = 4.;
int countRdf, limitRdf = 100;
int sizeHistRdf = 200; 
int stepRdf = 50;

// Global variables required for the diffuction calculations
TBuf *tBuf; //creates a pointer called tBuf of typeTBuf (data buffers)
double *rrDiffuseAv; //creates a pointed called rrDiffuseAv (averaged MSD) of type real
int countDiffuseAv;
int limitDiffuseAv = 200;
int nBuffDiffuse = 10;
int nValDiffuse = 1200;
int stepDiffuse = 3; // the last 4 need to be defined in order to run the program!!

// Simulation Parameters
int runId = 1;
int cellSize = 6; 
double density = 0.8; //unitless density of a unit cell, atoms per unit cell (area)
double temperature = 0.7; // dimensionless temperature
double deltaT = 0.001; // dimensionless time step
int randSeedP = 17;
int stepAvg = 100;
int stepEquil = 10000;
int stepAdjustTemp = 100;
int stepLimit; // Simulation limit is defined in SetParams based on Diffusion Buffers


int main(){
    SetParams ();
    SetupJob ();
    moreCycles = 1;

            printf("%s %f\n", "Temperature", temperature);
            printf("%s %d\n", "Number of Atoms", nMol);
            printf("%s\n", " ");

    FILE *MSimPtr;
    MSimPtr = fopen("project4results_NeighborList.csv","w");

    FILE *MSimRDFPtr;
    MSimRDFPtr = fopen("project4RDF_NeighborList.csv","w");

    FILE *MSimDiffPtr;
    MSimDiffPtr = fopen("project4Diff_NeiighborList.csv", "w");


    if (MSimPtr == NULL){
        printf("Error! Could not open results file/n");
    }
    else{
        fprintf(MSimPtr, "%s, %d\n", "Run ID", runId);
        fprintf(MSimPtr, "%s, %d\n", "Cell Size", cellSize);
        fprintf(MSimPtr, "%s, %f\n", "Density", density);
        fprintf(MSimPtr, "%s, %f\n", "Temperature", temperature);
        fprintf(MSimPtr, "%s, %d\n", "Number of Atoms", nMol);
        fprintf(MSimPtr, "%s, %f\n", "Outer Shell Distance", rNebrShell);
        fprintf(MSimPtr, "%s, %f\n", "Time Step", deltaT);
        fprintf(MSimPtr, "%s, %d\n", "Step Average", stepAvg);
        fprintf(MSimPtr, "%s, %d\n", "Steps before Equilibrium", stepEquil);
        fprintf(MSimPtr, "%s, %d\n", "Steps until Temperature Adjustment", stepAdjustTemp);
        fprintf(MSimPtr, "%s, %d\n", "Step Limit", stepLimit);
        fprintf(MSimPtr, "%s,\n", " ");
       fprintf(MSimPtr, "%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s\n", "Step", "Time", "V Sum",\
        "Total Energy", "TE Variance", "TE Fluctuation", "Potential Energy", "PE Variance", "PE Fluctuation",\
        "Kinetic Energy", "KE Variance", "KE Fluctuation",  "Pressure", "P Variance", "P Fluctuation",  "Lattice Correlation");
    }

    if (MSimRDFPtr == NULL){
        printf("Error! Could not open results file/n");
    }
    else{
        fprintf(MSimRDFPtr, "%s, %d\n", "Run ID", runId);
        fprintf(MSimRDFPtr, "%s, %d\n", "Cell Size", cellSize);
        fprintf(MSimRDFPtr, "%s, %f\n", "Density", density);
        fprintf(MSimRDFPtr, "%s, %f\n", "Temperature", temperature);
        fprintf(MSimRDFPtr, "%s, %d\n", "Number of Atoms", nMol);
        fprintf(MSimRDFPtr, "%s, %f\n", "RDF Range", rangeRdf);
        fprintf(MSimRDFPtr, "%s, %f\n", "Delta R", deltaR);
        fprintf(MSimRDFPtr, "%s, %d\n", "Histogram Size", sizeHistRdf);
        fprintf(MSimRDFPtr, "%s,\n", " ");
    }

    if (MSimDiffPtr == NULL){
        printf("Error! Could not open results file/n");
    }
    else {
        fprintf(MSimDiffPtr, "%s, %d\n", "Run ID", runId);
        fprintf(MSimDiffPtr, "%s, %d\n", "Cell Size", cellSize);
        fprintf(MSimDiffPtr, "%s, %f\n", "Density", density);
        fprintf(MSimDiffPtr, "%s, %f\n", "Temperature", temperature);
        fprintf(MSimDiffPtr, "%s, %d\n", "Number of Atoms", nMol);
        fprintf(MSimDiffPtr, "%s, %d\n", "Total Number of Diff Calcs", limitDiffuseAv);
        fprintf(MSimDiffPtr, "%s, %d\n", "Number of Buffers", nBuffDiffuse);
        fprintf(MSimDiffPtr, "%s, %d\n", "Number of Diffusion Measurements", nValDiffuse);
        fprintf(MSimDiffPtr, "%s, %d\n", "Step Size of Diffusion Measurement", stepDiffuse);
    }

    while (moreCycles)  
    {
        SingleStep (); 
        if (stepCount >= stepLimit) moreCycles = 0; 
    }
}


void SetParams () {
    VSetAll(initUcell, cellSize); // size of unit cell, dimensionless lengths
    stepLimit = stepEquil + stepDiffuse * nValDiffuse * (1. + ( limitDiffuseAv / nBuffDiffuse )); // Simulation steps needed to run all buffers

    nebrTabFac = 100; // maximum neighbor list size (increase this for higher densities if Seg. Fault occurs)
    rCut = 3; // This is the cut off radius for a soft disk fluid (no cut off tail)
    VSCopy (region, 1./pow(density/4.,1./3.), initUcell);
    nMol = 4 * VProd(initUcell);  // number of molecules is calculated buy multiplying the number of unit cells in each dimension
    VelMag = sqrt (NDIM * (1. - 1./nMol) * temperature);  // Used to assign initial velocities
    nebrTabMax = nebrTabFac*nMol; //specifies the max # of atom pairs, used for allocating enough memory to nebrTab
}

void SetupJob() {
    timeNow = 0;
    stepCount = 0;
    nebrNow = 1; //when nebrNow = 1, the neighbor list MUST BE UPDATED
    countRdf = 0;
    deltaR = rangeRdf / sizeHistRdf; //deltaR is the width of the RDF shell, i.e. Δr

    AllocArrays ();
    InitCoords ();
    InitVels ();
    InitAccels ();
    InitDiffusion();
    AccumProps (0);
}

// Objective: Allocate arrays which are dependent on the system size
void AllocArrays() {
    int nb;

    AllocMem(mol, nMol, Mol); //allocated 3D array for particle components
    AllocMem(nebrTab, 2*nebrTabMax, int); //allocates a 1D array (nebrTab) of type ‘int’ and size ‘2*nebrTabMax’
    AllocMem(histRdf, sizeHistRdf, real);

    //creates buffers required for diffusion calculations
    AllocMem(rrDiffuseAv, nValDiffuse, real);
    AllocMem (tBuf, nBuffDiffuse, TBuf);
    for (nb = 0; nb< nBuffDiffuse; nb ++){ // creates nb buffers
        AllocMem (tBuf[nb].orgR, nMol, VecR); // stores the coordinates of each atom at the beginning of each buffer period
        AllocMem (tBuf[nb].rTrue, nMol, VecR); // stores the actual coordinates of each atom every stepDiffuse timesteps
        AllocMem (tBuf[nb].rrDiffuse, nValDiffuse, double); // stores the MSD for each 
    }
}

// Objective: Initialize atoms in an FCC structure
void InitCoords () {
    VecR c, gap;
    int j, n, nx, ny, nz;
    VDiv(gap, region, initUcell); // vector quantitiy 'gap' is the length of a unit cell
    n = 0;

    for (nz = 0; nz < initUcell.z; nz ++) {
        for (ny = 0; ny < initUcell.y; ny ++) {
            for (nx = 0; nx < initUcell.x; nx ++) {
                VSet(c, nx + 0.25, ny + 0.25, nz + 0.25);
                VMul(c, c, gap);
                VVSAdd(c, -0.5, region);
                for (j = 0; j < 4; j ++) {
                    mol[n].r = c;
                    if (j != 3){
                        if (j != 0) mol[n].r.x += 0.5 * gap.x;
                        if (j != 1) mol[n].r.y += 0.5 * gap.y;
                        if (j != 2) mol[n].r.z += 0.5 * gap.z;
                    }
                    ++ n;
                }
            }
        }
    }
}

void InitVels () {
    int n;
    VZero (vSum);

    DO_MOL {
        mol[n].rv.x = VRand();
        mol[n].rv.y = VRand();
        mol[n].rv.z = VRand();
        VScale (mol[n].rv, VelMag);
        VVAdd (vSum, mol[n].rv);
    }
    DO_MOL VVSAdd (mol[n].rv, -1./nMol, vSum);
}

double VRand() {
    static int avalible = 0;
    static double gset;
    double fac, rsq, v1, v2;
    if(!avalible) {
        do {
            v1 = 2. * RandR() - 1; 
            v2 = 2. * RandR() - 1; 
            rsq =  v1 * v1 + v2 * v2;
        } while(rsq >= 1.0 || rsq == 0);
        fac = sqrt(-2.0 * log(rsq) / rsq);
        gset = v1 * fac;
        avalible = 0;
        return v2 * fac;
    }
    else{
        avalible = 1;
        return gset;
    }
}

double RandR () {
    randSeedP = (randSeedP * IMUL + IADD) & MASK;
    return (randSeedP * SCALE);
}

void InitAccels () {
    int n;
    DO_MOL VZero (mol[n].ra);
}

void InitDiffusion() {
    int nb;

    for (nb = 0; nb < nBuffDiffuse; nb ++) tBuf[nb].count = -nb * nValDiffuse / nBuffDiffuse; // Loop through all buffers, 'counter' represents the spacing between measurements
    ZeroDiffusion();
}

void ZeroDiffusion () {
    int j;
    countDiffuseAv = 0; // When countDiffuseAv = limitDiffuseAv, compute diffusion coefficient and print
    for (j = 0; j < nValDiffuse; j ++) rrDiffuseAv[j] = 0.;
}

void AccumProps (int icode) {
    if (icode == 0) {
        PropZero (totEnergy);
        PropZero (kinEnergy);
        PropZero (pressure); 
        PropZero (potEnergy); 
        PropZero (momentum); // initialize property (Prop) vectors to zero if icode == 0
    }
    else if (icode == 1) {
        PropAccum (totEnergy);
        PropAccum (kinEnergy);
        PropAccum (pressure); 
        PropAccum (potEnergy); 
        PropAccum (momentum); // Compute the sum of TE, KE, and P as well as the sum of TE^2, PE^2, and P
    }
    else if (icode == 2) {
        PropAvg (totEnergy, stepAvg);
        PropAvg (kinEnergy, stepAvg);
        PropAvg (pressure, stepAvg); 
        PropAvg (potEnergy, stepAvg); 
        PropAvg (momentum, stepAvg); // Calculates average values and standard deviations
    }
}

void SingleStep () {
    ++ stepCount;
    timeNow = stepCount * deltaT;

    LeapfrogStep(1);
    ApplyBoundaryConditions();
    if (nebrNow) { 
        nebrNow = 0; 
        dispHi = 0.;
        BuildNebrList ();
    }
    ComputeForces ();
    LeapfrogStep (2);
    EvalProps (); 
    if ((stepCount < stepEquil) && (stepCount % stepAdjustTemp == 0)) AdjustTemp();
    if (stepCount >= stepEquil && (stepCount - stepEquil) % stepRdf == 0) EvalRdf();
    if (stepCount >= stepEquil && (stepCount - stepEquil) % stepDiffuse == 0) EvalDiffusion();
    AccumProps (1);

    if (stepCount % stepAvg == 0)
    { 
        AccumProps (2);
        EvalLatticeCorr();
        PrintSummary();
        AccumProps (0);
    }
}

void ApplyBoundaryConditions() {
    int n;
    DO_MOL VWrapAll (mol[n].r);
}

void BuildNebrList() { 
    VecR dr;
    real rrNebr, rr; int j1, j2;

    rrNebr = Sqr (rCut+rNebrShell);
    nebrTabLen = 0; //counts the # of atom pairs... initialized to zero 
    for (j1 = 0; j1 < nMol-1; j1++){
        for (j2 = j1+1; j2 < nMol; j2++){
            VSub(dr, mol[j1].r, mol[j2].r); //interatomic separation 
            VWrapAll(dr); //minimum image convention
            rr = VLenSq (dr);

            if(rr < rrNebr){
                // if(nebrTabLen >= nebrTabMax) ErrExit(ERR_TOO_MANY_NEBRS); 
                nebrTab[2*nebrTabLen] = j1;
                nebrTab[2*nebrTabLen+1] = j2;
                ++nebrTabLen; 
            }
        }
    }
}

void ComputeForces() {
    VecR dr;
    double fcVal, rr, rrCut, rri, rri3;
    int j1, j2, n;

    rrCut = Sqr(rCut);
    DO_MOL VZero (mol[n].ra);
    uSum = 0.;
    virSum = 0.;
    for(n=0;n<nebrTabLen;n++) { 
        j1 = nebrTab[2*n];
        j2 = nebrTab[2*n+1];
        VSub (dr, mol[j1].r, mol[j2].r);
        VWrapAll (dr);
        rr = VLenSq (dr);
        if (rr < rrCut){
            rri = 1./ rr;
            rri3 = Cube (rri);
            fcVal = 48. * rri3 * (rri3 - 0.5) * rri;
            VVSAdd (mol[j1].ra, fcVal, dr);
            VVSAdd (mol[j2].ra, -fcVal, dr);
            uSum += 4. * rri3 * (rri3 - 1.);
            virSum += fcVal * rr;
        }
    }
}

// Objective: Numerically integrate position and velocity vectors forward in time using the leapfrog method
void LeapfrogStep (int part) {
    int n;

    // First step of numerical integration
    if (part == 1) {
        DO_MOL {
            VVSAdd (mol[n].rv, 0.5*deltaT, mol[n].ra); // Integrate velocity for one half time step (Equation 18)
            VVSAdd (mol[n].r, deltaT, mol[n].rv); // Integrage position for one full time step (Equation 19)
        }
    }

    // Second part of numeical integration
    else {
        DO_MOL VVSAdd (mol[n].rv, 0.5*deltaT, mol[n].ra); // Integrate velocity for second half time step (Equation 20)
    }
}

// Objective: Scale all velocity vectors to maintain an average velocity i.e. temp equal to VelMag
void AdjustTemp () {
    double vFrac, vvSum;
    int n;
    vvSum = 0.;

    DO_MOL vvSum += VLenSq (mol[n].rv);
    vFrac = VelMag / sqrt(vvSum/nMol);
    DO_MOL VScale (mol[n].rv, vFrac);
}

void EvalProps () {
    double vv, vvSum, vv2Sum, vvMax; 
    int n;

    VZero (vSum);
    vvSum = 0.;
    vvMax = 0.;

    DO_MOL {
        VVAdd (vSum, mol[n].rv); //compute sum of velocities (separate sums for x and y components) vv = VLenSq (mol[n].rv); //compute velocity squared (vx^2 + vy^2)
        vv = VLenSq(mol[n].rv);
        vvSum += vv; //compute sum of v^2 for kinetic energy calculation
        vvMax = Max (vvMax, vv);
    }
    kinEnergy.val = 0.5 * vvSum / nMol; //KE per atom
    totEnergy.val = kinEnergy.val + uSum / nMol; //Total Energy = KE + PE pressure.val = density * (vvSum + virSum) / (nMol * NDIM); //equation 30 }
    pressure.val = density*(vvSum + virSum) / (nMol * NDIM); // from Virial theorem
    potEnergy.val = uSum / nMol;
    momentum.val = VCSum (vSum) / nMol;

    dispHi += sqrt (vvMax) * deltaT; //Keeps a running sum of the max atomic displacement during time interval Δt
    if (dispHi > 0.5 * rNebrShell) nebrNow = 1; //if nebrNow=1, refresh the neighbor list at the next timestep (see equation 7)
}

void EvalRdf (){
    VecR dr;
    double normFac, rr; 
    int j1, j2, n;

    if (countRdf == 0) {
        for (n = 0; n < sizeHistRdf; n ++) histRdf[n] = 0.; //initialize all histogram values to zero 
    }
    
    deltaR = rangeRdf / sizeHistRdf; //deltaR is the width of the shell, i.e. Δr
    for (j1 = 0; j1 < nMol - 1; j1 ++) {
        for (j2 = j1 + 1; j2 < nMol; j2 ++) { //consider all atom pairs (i,j)
            VSub (dr, mol[j1].r, mol[j2].r); //calculate separation distance between j1 and j2 
            VWrapAll (dr); //MINIMUM IMAGE CONVENTION (perform periodic wrapround if needed) 
            rr = VLenSq (dr);
            if (rr < Sqr (rangeRdf)) {
                n = sqrt (rr) / deltaR;
                ++ histRdf[n];
            }
        }
    }
    
    ++ countRdf;
    if (countRdf == limitRdf) {
        normFac = VProd (region) / (2. * M_PI * Cube (deltaR) * Sqr (nMol) * countRdf);
        for (n = 0; n < sizeHistRdf; n ++) histRdf[n] *= normFac / Sqr (n - 0.5);
        PrintRdf();
        countRdf = 0;
    }
}

void EvalLatticeCorr(){
    VecR kVec;
    double si, sr, t;
    int n;
    kVec.x = 2. * M_PI * initUcell.x / region.x; // Assuming Cubic lattice
    kVec.y = - kVec.x;
    kVec.z = kVec.x;
    sr = 0.;
    si = 0.;
    
    DO_MOL {
        t = VDot (kVec, mol[n].r);
        sr += cos (t);
        si += sin (t);
    }

    latticeCorr = sqrt (Sqr (sr) + Sqr (si)) / nMol;
}

void EvalDiffusion () {
    VecR dr;
    int n, nb, ni; // nb is the current buffer

    for (nb = 0; nb < nBuffDiffuse; nb ++) { // loops through all buffers
        if (tBuf[nb].count == 0) { // if the counter for a particular buffer = 0, store inital coordinates
            DO_MOL {
                tBuf[nb].orgR[n] = mol[n].r; //original coordinates
                tBuf[nb].rTrue[n] = mol[n].r; // true/actual coordinates
            }
        }

        if (tBuf[nb].count >= 0){ // if the counter for a buffer has started, computer MSD and store buffer
            ni = tBuf[nb].count; // integer value 'i' goes from 0 to nValDiffuse
            tBuf[nb].rrDiffuse[ni] = 0; // set the running sum of MSD equal to zero
            DO_MOL{
                VSub (dr, tBuf[nb].rTrue[n], mol[n].r);
                VDiv ( dr, dr, region);
                dr.x = round (dr.x); // nearest integer function nint does not exsist in math.h library
                dr.y = round (dr.y);
                dr.z = round (dr.z);
                VMul (dr, dr, region);
                VAdd (tBuf[nb].rTrue[n], mol[n].r, dr);
                VSub (dr, tBuf[nb].rTrue[n], tBuf[nb].orgR[n]);
                tBuf[nb].rrDiffuse[ni] += VLenSq (dr);
            }
        }
        ++ tBuf[nb].count;
    }
    AccumDiffusion();
}

void AccumDiffusion() {
    double fac;
    int j, nb;

    for (nb = 0; nb < nBuffDiffuse; nb ++) { //loop through all buffers
        if (tBuf[nb].count == nValDiffuse) { // if the buffer reaches nValDiffuse
            for (j = 0; j < nValDiffuse; j ++) rrDiffuseAv[j] += tBuf[nb].rrDiffuse[j]; // Add tBuf[nb].rrDiffuse[j] to rrDiffuseAv[j] (keep running sum)
            tBuf[nb].count = 0; // reset the buffer count to zero
            ++ countDiffuseAv; // increment count that determines when to average over buffers and print difffusion coefficient
            if (countDiffuseAv == limitDiffuseAv) { // When this counter reaches limitDiffuseAv
                fac = 1. / (NDIM * 2 * nMol *stepDiffuse * deltaT * limitDiffuseAv);
                for (j = 1; j < nValDiffuse; j ++) rrDiffuseAv[j] *= fac / j; 
                PrintDiffusion();
                ZeroDiffusion();
            }
        }
    }
}

void PrintSummary (FILE *fp){
    fp  = fopen("project4results_NeighborList.csv","a"); //open file for data storage

    fprintf (fp,"%5d, %8.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f, %7.4f\n", 
    stepCount, timeNow, VCSum (vSum) / nMol, PropEst (totEnergy), PropEst (potEnergy), PropEst (kinEnergy), PropEst (pressure), latticeCorr);

    // fclose(fp); //Using close removes the first four time enteries from the csv file??
}

void PrintRdf (FILE *fp){

    fp = fopen("project4RDF_NeighborList.csv","a");
    real rb; //The ‘r’ distance
    int n;

    fprintf (fp, "rdf\n");
    for (n = 0; n < sizeHistRdf; n ++) {
        rb = (n + 0.5) * rangeRdf / sizeHistRdf; //Recall that we compute g(r) at the midpoint of each shell 
        fprintf (fp, "%8.4f, %8.4f\n", rb, histRdf[n]);
    } 
}

void PrintDiffusion (FILE *fp) {
    fp = fopen("project4Diff_NeiighborList.csv","a");
    double tVal;
    int j, stepVal;

    fprintf (fp, "diffusion\n");
    for (j = 0; j < nValDiffuse; j ++) {
        stepVal = j * stepDiffuse;
        tVal = stepVal * deltaT;
        fprintf (fp, "%8.4d, %8.4f, %8.4f\n", stepVal, tVal, rrDiffuseAv[j]);
    }
}