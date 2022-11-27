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
* The purpose of the SimUpdate class is to run through all possible directories 
* and determine which hpc jobs have completed how many iterations.
*
* @author Matthew Dorsey (madorse2@ncsu.edu)
*/
public class SimUpdate {

    // CLASS CONSTANTS
    
    /** different square models */
    public static final String[] SQUARE = {"2x2"};
    /** different dipoles */
    public static final String[] DIPOLE = {"stan", "stre"};
    /** different chirality fractions */
    public static final String[] XA = {"a100", "a050"};
    /** lower density limit */
    public static final int DENSITY_LOW = 5;
    /** upper density limit */
    public static final int DENSITY_HIGH = 75;
    /** maximum number of anneal incrementation */
    public static final int MAX_ANNEAL_INC = 71;
    /** name of output file */
    public static final String OUTFILE = "simUpdate.csv";
    /** out file header */
    public static final String OUTFILE_HEADER = "square, dipole, xa, density, n";
 
    /**
    * Loop through all possible directories and determine if any simulations
    * are running in that folder. If there are valid files, determine which
    * incrementation they are on.
    */
    public static void main(String[]args){
    
        // verify args length is 0
        if (args.length != 0) {
            System.out.println("Usage: java SimUpdate");
            System.exit(1);
        }
        
        // establish print writer to output file
        String updateLocation = OUTFILE;
        FileOutputStream outStream = null;
        try {
            outStream = new FileOutputStream (updateLocation);
        } catch (FileNotFoundException e) {
            // exit program
            System.out.println("Unable to access output printer");
            System.exit(1);
        }
        PrintWriter updatePrinter = new PrintWriter (outStream);
        updatePrinter.println(OUTFILE_HEADER);
        
        for (int squ = 0; squ < SQUARE.length; squ++) {
            for (int dipole = 0; dipole < DIPOLE.length; dipole++) {
                for (int xa = 0; xa < XA.length; xa++) {
                    // establish first directory
                    String firstDirectory = SQUARE[squ] + "/";
                    String secondDirectory = DIPOLE[dipole] + "/";
                    String thirdDirectory = XA[xa] + "/";
                    // System.out.println("First Directory: " + firstDirectory);
                    for (int den = DENSITY_LOW; den < DENSITY_HIGH; den = den + 5) {
                        String densityString = null;
                        if (den < 10) {
                            densityString = "0" + Integer.toString(den);
                        } else {
                            densityString = Integer.toString(den);
                        }
                        // establish fourth directory and the path
                        String fourthDirectory = "e" + densityString + "/";
                        String path = firstDirectory + secondDirectory + thirdDirectory + fourthDirectory;
                        int inc = 0;
                        do {
                            String incString = "";
                            if (inc < 10) {
                                incString = "00" + Integer.toString(inc);
                            } else if (inc < 100) {
                                incString = "0" + Integer.toString(inc);
                            } else if (inc < 1000) {
                                incString = Integer.toString(inc);
                            }
                            // indicator of type of square
                            String square = null;
                            if (SQUARE[squ] == SQUARE[0]) {
                                square = "2";
                            } else {
                                square = "3";
                            }
                            // indicator of dipole
                            String dp = null;
                            if (dipole == 0) {
                                dp = "A";
                            } else if (dipole == 1) {
                                dp = "E";
                            }
                            // indicator of chirality
                            String chirality = XA[xa].substring(0,3);
                            
                            // establish file
                            String file = "polsquare" + square + dp + 
                                chirality + "e" + densityString + "_" + incString + ".txt";
                            String fileLoc = path + file;
                            //System.out.println(fileLoc);
                            
                            // attempt to open file
                            FileInputStream inStream = null;
                            try {
                                inStream = new FileInputStream (fileLoc);
                            } catch (FileNotFoundException e) {
                                break;
                            }
                            inc++;
                        } while (inc < MAX_ANNEAL_INC);
                        
                        // record results if file was found
                        if (inc > 0) {
                            updatePrinter.println(SQUARE[squ] + "," + DIPOLE[dipole] + "," + 
                                XA[xa] + "," + den + "," + inc);
                        }
                    }
                }
            }
        }
    updatePrinter.close();
    }
}
