import java.util.Arrays;
import java.util.Scanner;
import java.io.PrintWriter;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.util.NoSuchElementException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.math.BigDecimal;
import java.lang.Math;

/** 
* [class description]
*
* @author Matthew Dorsey (madorse2@ncsu.edu)
*/
public class SimAnalysis {

    // CLASS CONSTANTS

    /** determines if the simulation is in debugging status */
    public static final boolean DEBUG = true;
    /** location of temp value in each equilibrium file */
    public static final int TEMP_INT = 2;
    /** location of the potential energy value in each equilibrium file */
    public static final int POT_INT = 4;
    /** location of poly2 order parameter information in each equilibrium file entry */
    public static final int POLY2_OP_INT = 9;
    /** location of full order parameter information in each equilibrium file entry */
    public static final int FULL_OP_INT = 10;
    /** location of percolation order parameter  information in each equilibrium file entry */
    public static final int PERCY_INT = 17;
    /** location of cluster information in each equilibrium file entry */
    public static final int CLUSTER_INT = 18;
    /** location of the nematic order parameter value in each equilibrium file */
    public static final int NEMATIC_INT = 19;
    /** boolean that determines if the nematic order parameter should be calculated */
    public static final boolean CALC_NEMATIC = true;
    /** boolean that determines if the head-to-tail order parameter should be calculated */
    public static final boolean CALC_H2T = false;
    /** boolean that determines if the anti-parallel order parameter should be calculated */
    public static final boolean CALC_ANTI = false;
    /** boolean that determines if the full assembly order parameter should be calculated */
    public static final boolean CALC_FULL = false;
    /** boolean that determines if the first single-stranded order parameter should be calculated */
    public static final boolean CALC_SS1 = true;
    /** boolean that determines if the second single stranded order parameter should be calculates */
    public static final boolean CALC_SS2 = true;
    /** boolean that determines if the first double-stranded order parameter should be calculated */
    public static final boolean CALC_DS1 = true;
    /** boolean that determines if the second double stranded order parameter should be calculated */
    public static final boolean CALC_DS2 = true;
    /** boolean that determines if the percolation order parameter should be calculated */
    public static final boolean CALC_PERC = true;
    /** header used names that order parameters output by calculation file */
    public static final String HEADER = "n,temp,pot,poly2,full,perc,nClust,nematic,ss1(jcalc), ss2(jcalc), ds1(jcalc), ds2(jcalc), perc(jcalc), nematic(jcalc)";
    
    // GLOBAL VARIABLES
    
    /** number of hard spheres in the squares */
    private static int numSpheres;
    /** location of the positively charged sphere in the square formation */
    private static int locPos;
    /** location of the negatively charged sphere in the square formation */
    private static int locNeg;
    /** maximum distance to consider two squares associated with one another */
    private static double maxDistAss;
    /** excluded area of square */
    private static double excludedArea;

    /** description - JavaDoc comment */
 
    /**
    * [method description]
    *
    * @param args command line arugements (not used)
    */
    public static void main(String[]args){
    
        // verify args length is 4
        if (args.length != 4) {
            System.out.println("Usage: java SimDataANAL [dimension of square] " + 
            " [type of dipole] [number fraction of A chirality squares] [density fraction]");
            System.exit(1);
        }
        
        String squ = args[0]; // modular dimension of square
        String dipole = args[1]; // type of dipole embedded inside the square
        String frac = args[2]; // chirality fraction in system of squares
        String density = args[3]; // area fraction of squares in system
        
        initalizeGlobalVariables (squ, dipole, frac, density);
        
        String dp = ""; // short hand string representation of dipole used for file management
        if (dipole.equals("stan")) {
            dp = "A";
        } else if (dipole.equals("stre")) {
            dp = "E";
        }
        
        String firstDirectory = squ + 'x' + squ + dipole + "/";
        String secondDirectory = 'a' + frac + "/";
        String thirdDirectory = 'e' + density + "/";
        if (DEBUG) {
            System.out.println("\n\n getting " + firstDirectory + secondDirectory + thirdDirectory);
        }
        
        // create printer
        String analLocation = firstDirectory + secondDirectory + squ + dp + "a" + frac + "e" + density + "anal.csv";
        PrintWriter analPrinter = createOutputPrinter (analLocation);
        FileOutputStream outStream = null;
        try {
            outStream = new FileOutputStream (analLocation);
        } catch (FileNotFoundException e) {
            System.out.println("Cannot create output file: " + analLocation);
            System.exit(1);
        }
        analPrinter.println(HEADER);
    
        int inc = 0;
        do {
            String printString = "";
            
            // establish incrementation and write to printer
            String incString = "";
            if (inc < 10) {
                incString = "00" + Integer.toString(inc);
            } else if (inc < 100) {
                incString = "0" + Integer.toString(inc);
            } else if (inc < 1000) {
                incString = Integer.toString(inc);
            }
            printString += incString + ",";
            
            // TODO open file for each simulation incrementation
            // determine if the file already exists
            // if it does read in the results from the file
            // otherwise calculate the order parameters that are not stored within the file
            
            
            
            /** OPEN AND SCAN EQUILIBRIUM FILE TO READ SIMULATION EQUILIBRIUM CALCULATIONS */
            
            // open sim file for storing annealing information
            String anneal = "polsquare" + squ + dp + "a" + frac.substring(0,2) + 'e' + density + '_' + incString + "_anneal.csv";
            String annealFile = firstDirectory + secondDirectory + thirdDirectory + anneal;
            
            // create op scanner
            FileInputStream annealInStream = null;
            try {
                annealInStream = new FileInputStream (annealFile);
            } catch (FileNotFoundException e) {
                System.out.println("Unable to access input file: " + annealFile);
                analPrinter.close();
                System.exit(1);
            }
            Scanner annealScanner = new Scanner (annealInStream);
            
            // parse info by passing scanner
            if (DEBUG) System.out.println ("Parsing: " + annealFile);
            printString += parseEquilFile (annealScanner);
            annealScanner.close();
            
            
            
            /** OPEN AND SCAN THE SPHERE XYZ FILE TO CALCULATE ORDER PARAMETERS */
            
            String xyzSph = "polsquare" + squ + dp + "a" + frac.substring(0,2) + 'e' + density + '_' + incString + "_sphmov.xyz";
            String xyzSphFile = firstDirectory + secondDirectory + thirdDirectory + xyzSph;
            
            // create the input scanner
            FileInputStream xyzSphStream = null;
            try {
                xyzSphStream = new FileInputStream (xyzSphFile);
            } catch (FileNotFoundException e) {
                System.out.println ("Unable to access input file: " + xyzSphFile);
                break;   
            }
            Scanner xyzSphScanner = new Scanner (xyzSphStream);
            
            // pass scanner to method and calculate order parameters
            if (DEBUG) System.out.println("Parsing: " + xyzSphFile);
            printString += parseOP_xyzSph (xyzSphScanner, density);
            xyzSphScanner.close();
            
            
            
            /** OPEN AND SCAN THE SQUARE XYZ FILE TO CALCULATE THE NEMATIC ORDER PARAMETER */
            
            String xyzSqu = "polsquare" + squ + dp + "a" + frac.substring(0,2) + 'e' + density + '_' + incString + "_squmov.xyz";
            String xyzSquFile = firstDirectory + secondDirectory + thirdDirectory + xyzSqu;
            
            // create input Scanner
            FileInputStream xyzSquStream = null;
            try {
                xyzSquStream = new FileInputStream (xyzSquFile);
            } catch (FileNotFoundException e) {
                System.out.println ("Unable to access input file: " + xyzSquFile);
                break;
                //analPrinter.close();
                //System.exit(1);
            }
            Scanner xyzSquScanner = new Scanner (xyzSquStream);
            
            // pass scanner to method and calculate the nematic order parameter
            if (DEBUG) System.out.println ("Parsing: " + xyzSquFile);
            printString += parseOP_xyzSqu (xyzSquScanner);
            xyzSquScanner.close();
                        
            // report results to user and write results to analysis summary files
            // TODO report results of user
            analPrinter.println(printString);
            // TODO create analysis file for individual incrementation 
            
            inc++;
        } while (inc <= 70);
        
        analPrinter.close();

    }
    
    /**
    * Private helper method that initializes constants associated with the simulation
    * and used for calculating order parameters.
    *
    * @param
    */
    private static void initalizeGlobalVariables (String square, String dipole, 
        String numberFraction, String areaFraction) {
            
            // determine the global constants according to the type of square
            if (square.equals("2")) {
                // 2x2 square
                maxDistAss = Math.sqrt(2.);
                excludedArea = 1. + ((3. / 4.) * Math.PI);
                if (dipole.equals("stan")) {
                    // 2x2 square with a standard dipole
                    numSpheres = 4;
                    locPos = 1;
                    locNeg = 2;
                } else {
                    // 2x2 square with a stretched dipole
                    numSpheres = 6;
                    locPos = 5;
                    locNeg = 6;
                }
            } else if (square.equals("3")) {
                // 3x3 square
                maxDistAss = Math.sqrt(3.);
                excludedArea = 4. + ((5. / 4.) * Math.PI);
                if (dipole.equals("stan")) {
                    // 3x3 square with a standard dipole
                    numSpheres = 8;
                    locPos = 1;
                    locNeg = 3;
                } else {
                    // 3x3 square with a stretched dipole
                    numSpheres = 10;
                    locPos = 9;
                    locNeg = 10;
                }
            }
        }
    
    /**
    * This method scans xyz files meant to display movies of squares. The method parses
    * simulation snapshots, creating an array of strings with each snapshot. Then, each
    * snapshot is passed to a method which calculates a particular order parameter. The
    * method returns a string containing a comma parsed list of the values of all the
    * order parameters calculating from the xyz file of squares. 
    *
    * @param fileScanner scanner that has already been connected to the xyz file of 
    *               squares
    * @return comma-parsed string containing the values of all of the order parameters
    *               calculated from the xyz file
    **/
    public static String parseOP_xyzSqu (Scanner fileScanner) {
        
        // prase through each screenshot, determine nematic OP for each snapshot
        double nematic = 0.;
        int count = 0;
        String snapshot;
        int lines = 0;
        do {
            try {
                snapshot = "";
                lines = fileScanner.nextInt(); // first line is the number of rows in snapshot
                fileScanner.nextLine(); // complete passing first line
                fileScanner.nextLine(); // second line is comment line
                for (int i = 0; i < lines; i++) {
                    snapshot += fileScanner.nextLine() + "\n"; // parse data about snapshot from xyz file
                }
                if (CALC_NEMATIC) nematic += calculateNematicOPsqu (lines, snapshot);
                count++;
            } catch (NoSuchElementException e) {
                break;
            }
        } while (fileScanner.hasNextLine());
        String returnString = "";
        returnString += (CALC_NEMATIC) ? String.valueOf(nematic / count) + "," : "NA,";
        return returnString;
    
    }
    
    /**
    * Method that calculates the value of the nematic order parameter of an xyz 
    * snapshot of squares. The method translates the quaternion (in the form x, y, 
    * z, w) which is stored in the snapshot for each square to create a list of each
    * square's angle relative to the x-axis. Then relative angle of each pair of squares
    * is compared and the nematic order parameter is calculated. Method returns the
    * calculated nematic order parameter for the snapshot as a double.
    *
    * @param num number of squares in the simulation snapshot
    * @param snapshot string containing the simulation snapshot in xyz format
    * @return value of the nematic order parameter for the simulation snapshot
    */
    public static double calculateNematicOPsqu (int num, String snapshot) {
    
        double nematic = 0;
        int count = 0;
        
        // parse the quaternion from each square and calculate it's angle
        double phi [] = new double [num]; // contains angle of each square
        Scanner snapScanner = new Scanner (snapshot);
        for (int i = 0; i < num; i++) {
            Scanner lineScanner = new Scanner (snapScanner.nextLine());
            lineScanner.next(); // particle number, should equal i
            lineScanner.next(); // x coordinate of square
            lineScanner.next(); // y coordinate of square
            double x = lineScanner.nextDouble();
            double y = lineScanner.nextDouble();
            double z = lineScanner.nextDouble();
            double w = lineScanner.nextDouble();
            
            // determine rotation matrix in order to calculate cosphi
            double m00 = 1. - 2. * Math.pow(y,2) - 2. * Math.pow(z,2);
            double m01 = (2. * x * y) + (2. * z * w);
            /* double m02 = (2. * x * z) - (2. * y * w);
            double m10 = (2. * x * y) - (2. * z * w);
            double m11 = 1. - 2. * Math.pow(x, 2) - 2. * Math.pow(z, 2);
            double m12 = (2. * y * z) + (2. * x * w);
            double m20 = (2. * x * z) + (2. * y * w);
            double m21 = (2. * y * z) - (2. * x * w);
            double m22 = 1. - 2. * Math.pow(x, 2) - 2. * Math.pow(y, 2);
            
            System.out.println("Quaternion (x, y, z, w): " + String.valueOf(x) + " " 
                + String.valueOf(y) + " " + String.valueOf(z) + " " + String.valueOf (w));
            System.out.println(String.valueOf(m00) + " " + String.valueOf(m01) + " " + String.valueOf(m02));
            System.out.println(String.valueOf(m10) + " " + String.valueOf(m11) + " " + String.valueOf(m12));
            System.out.println(String.valueOf(m20) + " " + String.valueOf(m21) + " " + String.valueOf(m22)); */
            phi[i] = Math.acos(m00);
            if (m01 < 0.) phi[i] = - phi[i];
            /* System.out.printf("%d %f %f %f %n", i, m00, m01, phi[i]/Math.PI);
            /* System.out.println(String.valueOf(i) + " " + String.valueOf(m00) + " " + String.valueOf(m01) + " " + String.valueOf(phi[i] / Math.PI));
            System.out.println (String.valueOf(i) + " " + String.valueOf(m00) + " " + String.valueOf(phi[i] * (180. / Math.PI))); */
            lineScanner.close();
        }
        
        // calculate the nematic order parameter 
        for (int i = 0; i < (num - 1); i++) {
            for (int j = i + 1; j < num; j++) {
                double theta = phi[i] - phi[j];
                if (theta < 1. && theta > - 1.) {
                    double val = Math.pow(Math.cos(theta), 2);
                    nematic += val;
                    count++;
                }
            }
        } 
        nematic /= count;
        nematic = ((3. * nematic) - 1.) / 2.;
        return nematic; 
    }
    
    /** 
    * [method description]
    * 
    * @param
    * @return 
    */
    public static String parseOP_xyzSph (Scanner fileScanner, String phi) {
        
        // initialize the values of the order parameters to calculate
        int count = 0;
        //double head2tail = 0.;
        //double antiparallel = 0.;
        //double full = 0.;
        double singleAss1 = 0.;
        double singleAss2 = 0.;
        double doubleAss1 = 0.;
        double doubleAss2 = 0.;
        double perc = 0.;
        
        // parse through file, collect snapshots and calculate order parameters 
        String snapshot;
        int lines = 0;
        do {
            try {
                snapshot = "";
                lines = fileScanner.nextInt(); // first line is the number of rows in snapshot
                fileScanner.nextLine(); // complete passing first line
                fileScanner.nextLine(); // second line is comment line
                for (int i = 0; i < lines; i++) {
                    snapshot += fileScanner.nextLine() + "\n"; // parse data about snapshot from xyz file
                }
                // calculate information about snapshot
                int numSquares = (lines / numSpheres);
                double region = Math.sqrt(excludedArea * numSquares / (Double.valueOf(phi) * 0.01));
                
                // parse information from snapshot
                double [][] coor = parseCoordinatesFromSnapshot (lines, snapshot);
                //int [] pol = parsePolarizationFromSnapshot (lines, snapshot);
                int [] chai = parseChiralityFromSnapshot (numSquares, snapshot);
                
                // TODO create a private class for each snapshot which contains 
                // global variables for relevant parameters
                
                // generate order list and calculate order parameters
                int [][][] orderList = genOrderList (region, coor, chai);
                //if (CALC_H2T) head2tail += calculateHead2TailAssembly (orderList);
                //if (CALC_ANTI) antiparallel += calculateAntiParallelAssembly (orderList);
                // calculate full assembly
                if (CALC_SS1) singleAss1 += calculateSingleAssembly1OP (orderList);
                if (CALC_SS2) singleAss2 += calculateSingleAssembly2OP (orderList);
                if (CALC_DS1) doubleAss1 += calculateDoubleAssembly1OP (orderList);
                if (CALC_DS2) doubleAss2 += calculateDoubleAssembly2OP (orderList);
                if (CALC_PERC) perc += calculatePercolationOP (region, orderList, coor);
                count++;
            } catch (NoSuchElementException e) {
                break;
            }
        } while (fileScanner.hasNext());
        
        // average the order parameters and return their values
        String returnString = "";
        //returnString += (CALC_H2T) ? (String.valueOf(head2tail / count) + ",") : "NA,";
        //returnString += (CALC_ANTI) ? (String.valueOf(antiparallel / count) + ",") : "NA,";
        //returnString += (CALC_FULL) ? (String.valueOf(full / count) + ",") : "NA,";
        returnString += (CALC_SS1) ? (String.valueOf(singleAss1 / count) + ",") : "NA,";
        returnString += (CALC_SS2) ? (String.valueOf(singleAss2 / count) + ",") : "NA,";
        returnString += (CALC_DS1) ? (String.valueOf(doubleAss1 / count) + ",") : "NA,";
        returnString += (CALC_DS2) ? (String.valueOf(doubleAss2 / count) + ",") : "NA,";
        returnString += (CALC_PERC) ? (String.valueOf(perc / count) + ",") : "NA,";
        return returnString;
        
    }
    
    /** 
    * Helper method that parses the sphere's coordinates in an xyz simulation snapshot 
    * into a two-dimensional array. The array is organized first by the order of the 
    * sphere in the simulation file, and then by the position coordinates.
    *
    * @param
    * @return 
    */
    public static double[][] parseCoordinatesFromSnapshot (int num, String snapshot) {
        
        // initialize the array
        // NOTE: number of dimensions have been HARD CODED
        double [][] coordinates = new double [num][2];
        
        // establish a scanner for the string
        Scanner stringScanner = new Scanner (snapshot);
        for (int i = 0; i < num; i++) {
            Scanner lineScanner = new Scanner(stringScanner.nextLine());
            coordinates[i][0] = lineScanner.nextDouble();
            coordinates[i][1] = lineScanner.nextDouble();
            lineScanner.close();
        } 
        
        return coordinates;
    }
    
    /**
    * Helper method that parses each sphere's polarization from an xyz simulation 
    * snapshot. The array is organized such that each element contains the polarization
    * of the sphere in the simulation snapshot, which is stored as 1 (positive),
    * 0 (neutral), or -1 (negative).
    *
    * @param 
    * @return 
    */
    public static int[] parsePolarizationFromSnapshot (int num, String snapshot) {
        
        // initialize the array
        int [] polarization = new int [num];
        
        // establish a scanner for the string
        Scanner stringScanner = new Scanner (snapshot);
        for (int i = 0; i < num; i++) {
            Scanner lineScanner = new Scanner(stringScanner.nextLine());
            lineScanner.next(); // the first element contains the x position
            lineScanner.next(); // the second element contains the y position
            String r = lineScanner.next(); // the third element contains the red coloring of the
            int pol = 0;
            if (r.equals("1")) pol = -1;
            else if (r.equals("0.1")) pol = 1;
            polarization[i] = pol;
            lineScanner.close();
        } 
        
        return polarization;
    }
    
    /**
    * Helper method that parses each sphere's chirality from an xyz simulation snapshot.
    * The array is organized such the each element contains the chirality of
    * the square in the simulation snapshot, which is stored either as 1 (A chirality) or
    * 2 (B chirality). The method relies on the RBG colors that are stored in the 
    * simulation snapshot file to determine the chirality.
    *
    * @param 
    * @return
    */
    public static int[] parseChiralityFromSnapshot (int num, String snapshot) {
        
        // initialize the array
        // the length of the array is the number of squares in the snapshot
        int[] chirality = new int [num];
        
        // establish a scanner for the string
        Scanner stringScanner = new Scanner (snapshot);
        for (int i = 0; i < num; i++) {
            for (int j = 0; j < numSpheres ; j ++) {
                String line = stringScanner.nextLine();
                if (j == (locPos - 1)) {
                    Scanner lineScanner = new Scanner(line);
                    lineScanner.next(); // the first element contains the x position
                    lineScanner.next(); // the second element contains the y position
                    lineScanner.next(); // the third element contains the red coloring of the polarized sphere
                    lineScanner.next(); // the fourth element contains the blue coloring of the polarized sphere
                    lineScanner.next(); // the fifth element contains the green coloring of the polarized sphere
                    int r = -1; // the sixth element contains the red coloring of the chiral square
                    try {
                        r = lineScanner.nextInt(); 
                    } catch (NoSuchElementException E) {
                        System.out.println("Issue parsing chirality color.");
                        System.out.println("Sphere Number: " + (i*numSpheres));
                    }
                    int chai = 0;
                    if (r == 0) chai = 1; // the color of A chirality squares is green
                    else if (r == 1) chai = 2; // the color of B chirality squares is orange
                    else System.exit(1); 
                    chirality[i] = chai;
                    lineScanner.close();
                }
            }
        } 
        
        return chirality;
        
    }
    
    /**
    * Method generates and order list, which is used to calculate order parameters.
    *
    * @param 
    * @return
    */
    public static int[][][] genOrderList (double regionLength, double[][] coordinates, int[] chirality) {
        
        final boolean DEBUG_ORDERLIST = false;
        
        // initialize parameters
        int numSquares = chirality.length;
        int [][][] orderList = new int [numSquares][2][10]; // all elements initialized to zero
        int [][] numPart = new int [numSquares][2]; // helper array that records the number of partners that each square has
        
        // initialize all the values in the order list to -1
        for (int i = 0; i < numSquares; i++) {
            for (int j = 0; j < 2; j++) {
                for (int k = 0; k < 10; k++) orderList [i][j][k] = -1;
            }
        }
        
        // loop through all pairs of squares 
        for (int i = 0; i < numSquares - 1; i ++) { // downlist square
            
            // determine the coordinates of the positively and negatively charged spheres in the ith square
            int iPos;
            int iNeg;
            if (chirality[i] == 1) { // if the square is A-chirality
                // the location of the positive and negative spheres are the same as the global variables
                iPos = square2Sphere (i, locPos);
                iNeg = square2Sphere (i, locNeg);
            } else { // if the square is B-chirality
                // the location of the positive and negative spheres are the opposite as the global variables
                iPos = square2Sphere (i, locNeg);
                iNeg = square2Sphere (i, locPos);
            }
            double[] iPosCoor = coordinates[iPos];
            double[] iNegCoor = coordinates[iNeg];
            for (int j = i + 1; j < numSquares; j ++) { // uplist square
            
                // determine the coordinates of the positively and negatively charged spheres in the jth square
                int jPos;
                int jNeg;
                if (chirality[j] == 1) { // if the square is A-chirality
                    // the location of the positive and negative spheres are the same as the global variables
                    jPos = square2Sphere (j, locPos);
                    jNeg = square2Sphere (j, locNeg);
                } else  { // if the square is B-chirality
                    // the location of the positive and negative spheres are the opposite of the global variables
                    jPos = square2Sphere (j, locNeg);
                    jNeg = square2Sphere (j, locPos);
                }
                double[] jPosCoor = coordinates[jPos];
                double[] jNegCoor = coordinates[jNeg];
                
                // determine if either of the oppositely charged spheres are within the maximum distance of one another
                if (calcDist(regionLength, iPosCoor, jNegCoor) < maxDistAss) {
                    orderList[i][0][numPart[i][0]++] = j;
                    orderList[j][1][numPart[j][1]++] = i;
                }
                if (calcDist(regionLength, iNegCoor, jPosCoor) < maxDistAss) {
                    orderList[i][1][numPart[i][1]++] = j;
                    orderList[j][0][numPart[j][0]++] = i;
                }
            }
        }
        
        double avg = 0;
        int count = 0;
        if (DEBUG) {
            for (int i = 0; i < numSquares; i++) {
                count++;
                avg += numPart[i][0] + numPart[i][1];
                if (DEBUG && DEBUG_ORDERLIST) {
                    String posPartners = " " + i + " positive partners: ";
                    String negPartners = " " + i + " negative partners: ";
                    for (int k = 0; k < 10; k++) {
                        posPartners += orderList[i][0][k] + " ";
                        negPartners += orderList[i][1][k] + " ";
                    }
                    System.out.println(posPartners + "\n" + negPartners);
                }
                
            }
            avg /= count;
            if (DEBUG && DEBUG_ORDERLIST) {
                System.out.println("Average number of partners per square: " + avg);
            }
        }
    
        return orderList;
    }
    
    /**
    * Method that calculates the head-to-tail assembly order parameter.
    *
    * @param 
    * @return
    */
    public static double calculateHead2TailAssembly (int[][][] orderList) {
        
        // initialize parameters
        double head2Tail = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares; i ++) { 
        
            // the order parameter is considered for each square
            count++;
            
            // determine the number of partners each charged sphere has
            int posPart = 0, negPart = 0;
            for (int j = 0; orderList[i][0][j] != -1; j++) posPart++;
            for (int j = 0; orderList[i][1][j] != -1; j++) negPart++;
            
            // determine if the square meets the constraints of the order parameter
            if (posPart >= 1 || negPart >= 1) head2Tail += 1.;
        }
    
        return head2Tail / count;
    }
    
    /**
    * Method that calculates the antiparallel assembly order parameter.
    *
    * @param
    * @return
    */
    public static double calculateAntiParallelAssembly (int[][][] orderList) {
        
        // initialize parameters
        double anti = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares; i++) {
            
            // the order parameter is considered for each square
            count++;
            
            // determine if any of the charged spheres are paired with the same square
            boolean op = false;
            for (int j = 0; orderList[i][0][j] != -1; j++) {
                for (int k = 0; orderList[i][1][k] != -1; k++) {
                    if (orderList[i][0][j] == orderList[i][0][k]) op = true;
                }
            }
            
            // if the conditions have been meet, add to the orderparameter
            if (op) anti += 1.;
        }
        
        return anti / count;
    }
    
    /** 
    * Method that calculates the full assembly order parameter.
    * 
    * @param
    * @return
    */
    public static double calculateFullAssembly (int[][][] orderList) {
        
        // initialize parameters 
        double full = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares; i++) {
             
             // the order parameter is considered for each square
             count++;
        }
        
        return full / count;
    }
    
    
    
    /**
    * Method that calculates the first single-strand assembly order parameter.
    *
    * @param 
    * @return
    */
    public static double calculateSingleAssembly1OP (int[][][] orderList) {
        
        // initialize parameters
        double singleAss = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares; i ++) { 
        
            // the order parameter is considered for each square
            count++;
            
            // determine the number of partners each charged sphere has
            int posPart = 0, negPart = 0;
            for (int j = 0; orderList[i][0][j] != -1; j++) posPart++;
            for (int j = 0; orderList[i][1][j] != -1; j++) negPart++;
            
            // determine if the square meets the constraints of the order parameter
            if (posPart >= 1 && negPart >= 1) singleAss += 1.;
        }
    
        return singleAss / count;
    }
    
    
    
    /**
    * Method that calculates the second single-strand assembly order parameter.
    *
    * @param 
    * @return
    */
    public static double calculateSingleAssembly2OP (int[][][] orderList) {
        
        // initialize parameters
        double singleAss = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares; i ++) { 
        
            // the order parameter is considered for each square
            count++;
            
            // determine the number of partners each charged sphere has
            int posPart = 0, negPart = 0;
            for (int j = 0; orderList[i][0][j] != -1; j++) posPart++;
            for (int j = 0; orderList[i][1][j] != -1; j++) negPart++;
            
            // determine if the square meets the constraints of the order parameter
            if (posPart == 1 && negPart == 1) singleAss += 1.;
        }
    
        return singleAss / count;
    }
    
    /**
    * Method that calculates the first double-strand assembly order parameter.
    *
    * @param 
    * @return
    */
    public static double calculateDoubleAssembly1OP (int[][][] orderList) {
        
        // initialize parameters
        double doubleAss = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares - 1; i ++) { 
        
            // the order parameter is considered for each square
            count++;
            
            // determine the number of partners each charged sphere has
            int posPart = 0, negPart = 0;
            for (int j = 0; orderList[i][0][j] != -1; j++) posPart++;
            for (int j = 0; orderList[i][0][j] != -1; j++) negPart++;
            
            // determine if the square meets the constraints of the order parameter
            if (posPart >= 2 && negPart >= 2) doubleAss += 1.;
        }
    
        return doubleAss /= count;
    }
    
    /**
    * Method that calculates the second double-strand assembly order parameter.
    *
    * @param 
    * @return
    */
    public static double calculateDoubleAssembly2OP (int[][][] orderList) {
        
        // initialize parameters
        double doubleAss = 0.;
        int count = 0;
        int numSquares = orderList.length;
        
        // loop through all squares
        for (int i = 0; i < numSquares - 1; i ++) { 
        
            // the order parameter is considered for each square
            count++;
            
            // determine the number of partners each charged sphere has
            int posPart = 0, negPart = 0;
            for (int j = 0; orderList[i][0][j] != -1; j++) posPart++;
            for (int j = 0; orderList[i][0][j] != -1; j++) negPart++;
            
            // determine if the square meets the constraints of the order parameter
            if (posPart == 2 && negPart == 2) doubleAss += 1.;
        }
    
        return doubleAss /= count;
    }
    
    /**
    * Method that calculates the percolation order parameter.
    *
    * @param 
    * @return
    */
    public static double calculatePercolationOP (double region, int[][][] orderList, double[][] coor) {
    
        // initialize parameters 
        int numSquares = orderList.length;
        int numDim = coor[0].length;
        boolean[] visited = new boolean[numSquares]; // determines if a square has already been visited, all elements initialized to false
        int[] cluster = new int[numSquares]; // cluster number of each square all elements are initialized to zero
        double[][] svec = new double[numSquares][numDim]; // spanning vector, all elements are initialized to zero
        
        int n = 0;
        for (int i = 0; i < numSquares; i ++) {
            if (!visited[i]) {
                boolean op = true; // initialize the boolean to true
                boolean[] perc = new boolean[coor[i].length]; // boolean array used for determining if the criteria of percolation have been met, initialized to false
                clusterAnal (perc, i, n, region, orderList, visited, cluster, coor, svec); // determine if the group is a part of a percolated cluster
                for (int m = 0; m < perc.length; m++) op = op && perc[m]; // cluster must be percolated in each dimension
                if (op) return 1; // if the boolean is still true, percolation conditions have been meet
            }
        }
        
        // if the method reaches this point, the cluster has not percolated
        return 0;
    }
    
    /**
    * Recursive method that determines if a cluster has percolated the periodic boundaries 
    * of a molecular simulation box/
    * 
    * @param
    * @return
    */
    private static void clusterAnal(boolean[] perc, int i, int n, double region, 
        int[][][] orderList, boolean[] visited, int[] cluster, double[][] coor, 
        double[][] svec){
        
        // tolerance for accepting percolation
        final double TOL = 0.05;
    
        // record that the square has been visited, and its cluster number
        visited[i] = true;
        cluster[i] = n;
        
        // loop through partners associated with positive and negative spheres
        for (int j = 0; j < orderList[i].length; j++) {
            for (int k = 0; orderList[i][j][k] != -1; k++) {
            
                int partner = orderList[i][j][k];
                
                // calculate the distance vector for the pair
                double[] dvec = new double[svec[i].length];
                for (int m = 0; m < perc.length; m++) {
                    dvec[m] = coor[i][m] - coor[partner][m];
                    if (dvec[m] < (-0.5 * region)) dvec[m] += region;
                    if (dvec[m] >= (0.5 * region)) dvec[m] -= region;
                }
                
                // determine if the partner has been visited
                if (visited[partner]){ // if the partner has been visited
                
                    // calculate the spanning vector and determine if the percolate criteria have been met
                    for (int m = 0; m < perc.length; m++) {
                        dvec[m] = svec[i][m] + dvec[m];
                        if (Math.abs(svec[partner][m] - dvec[m]) >= (region - TOL)) perc[m] = true; 
                    }
                } else { // if the partner has not been visited
                
                    // calculate and store the spanning vector for the partner
                    for (int m = 0; m < perc.length; m++) {
                        svec[partner][m] = svec[i][m] + dvec[m];
                    }
                    
                    // call the recursive method for the partner
                    clusterAnal(perc, partner, n, region, orderList, visited, cluster, coor, svec);
                }
            }
        }
    }
    
    /** 
    * Helper method that calculates the integer associated with a sphere according to
    * the spheres order in the square formation and the integer associated with square.
    *
    * @param
    * @return 
    */
    public static int square2Sphere (int n, int spherePos) {
        return n * numSpheres + spherePos - 1;
    }
    
    /**
    * Helper method that calculates the distance between two spheres according
    * to their coordinates.
    * 
    * @param
    * @return 
    */
    public static double calcDist (double regionLength, double[] iCoor, double[] jCoor) {
        
        // initialize constants
        double dist = 0.;
        int numDim = iCoor.length;
        double [] rij = new double[numDim]; // initialized to zero
        
        // calculate the distance between the pair in each dimension
        for (int m = 0; m < numDim; m++) {
            rij[m] = iCoor[m] - jCoor[m];
            // apply period boundary conditions
            if (rij[m] < (-0.5 * regionLength)) rij[m] += regionLength;
            if (rij[m] >= (0.5 * regionLength)) rij[m] -= regionLength;
            dist += Math.pow(rij[m], 2.);
        }
        
        return Math.sqrt(dist);
    }
    
    /**
    * This method determines is a string passed to the method is in scientific 
    * notation format. 
    *
    * @param numberString string containing the number to examine
    * @return true if the number string is in scientific notation format, else false
    */
    public static boolean isScientificNotation(String numberString) {

        // Validate number
        try {
            new BigDecimal(numberString);
        } catch (NumberFormatException e) {
            return false;
        }

        // Check for scientific notation
        return numberString.toUpperCase().contains("E");   
    }
    
    /**
    * [method description]
    *
    * @param
    * @return
    */
    public static String parseEquilFile (Scanner equilScanner) {
    
        double temp = 0.;
        double pot = 0.;
        double poly2OP = 0.;
        double fullOP = 0.;
        double percy = 0.;
        double nClust = 0.;
        double nem = 0.;
        int count = 0;
        
        // establish scanner to annealing file
        // Scanner annealScanner = createInputScanner (annealFile);
        
        // parse through header
        equilScanner.nextLine();
        
        // grab each entry and pull info
        do {
            String equilString = "";
            try {
                equilString += equilScanner.nextLine();
            } catch (NoSuchElementException e) {
                temp /= count;
                pot /= count;
                poly2OP /= count;
                fullOP /= count;
                percy /= count;
                nClust /= count;
                nem /= count;
                //equilScanner.close();
                return "" + temp + "," + pot + "," + poly2OP + "," + fullOP + ", " + 
                    percy + "," + nClust + "," + nem + ",";
            }
            
            count++;
            temp += parseEquilString (equilString, TEMP_INT);
            pot += parseEquilString (equilString, POT_INT);
            poly2OP += parseEquilString (equilString, POLY2_OP_INT);
            fullOP += parseEquilString (equilString, FULL_OP_INT);
            percy += parseEquilString (equilString, PERCY_INT);
            nClust += parseEquilString (equilString, CLUSTER_INT);
            nem += parseEquilString (equilString, NEMATIC_INT);
            
        } while (equilScanner.hasNextLine());
        
        temp /= count;
        pot /= count;
        poly2OP /= count;
        fullOP /= count;
        percy /= count;
        nClust /= count;
        nem /= count;
        // equilScanner.close();
        return "" + temp + "," + pot + "," + poly2OP + "," + fullOP + ", " + 
            percy + "," + nClust + "," + nem + ",";
        
    }
    
    /**
    * [method description]
    * @param
    * @return
    */
    public static double parseEquilString (String annealString, int delimiterInt) {
        Scanner annealScanner = new Scanner (annealString);
        annealScanner.useDelimiter(",");
        
        // move through string until full op value
        for (int i = 0; i < delimiterInt; i++) {
            String debug = annealScanner.next();
        }
        String real = annealScanner.next();
        
        if (isScientificNotation(real)) {
            return Double.valueOf(real).longValue();
        } else {
            return Double.valueOf(real);
        }
    }
    
    /**
    * [mutator method description]
    *
    * @param 
    * @return
    */
    public static PrintWriter createOutputPrinter (String outFile) {
        FileOutputStream outStream = null;
        Scanner console = new Scanner (System.in);
        // Path path = Path.of(outFile);
        try {
            outStream = new FileOutputStream (outFile);
            /* if (Files.exists(path)) {
                //System.out.print(outFile + " exists - OK to overwrite (y,n)?: ");
                // String response = console.next();
                String response = "y";
                if ((response.charAt(0) != 'y') && (response.charAt(0) != 'Y')) {
                    System.exit(1);
                } else {
                    outStream = new FileOutputStream (outFile);
                }
            } else {
                outStream = new FileOutputStream (outFile);
            } */
        } catch (FileNotFoundException e) {
            System.out.println("Cannot create output file: " + outFile);
            System.exit(1);
        }
        return new PrintWriter (outStream);
    }
}
