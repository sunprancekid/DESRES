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
* The ProgramToEcho class is a procedural program that
* converts programs to bash scripts that, when executed,
* echo each line of the program to a file specified file.
*
* @author Matthew Dorsey (madorse2@ncsu.edu)
*/

public class ProgramToEcho {

    /** name of bash script generated by program */
    public static final String BASH = "echoprogram.sh";

    /**
    * Main method. Accepts one argument, the file to convert into
    * a bash script.
    *
    * @param args String of arguments accepted from command line terminal.
    * @author Matthew Dorsey (madorse2@ncsu.edu)
    */
    public static void main(String[] args) {
        
        // the main method only accepts one argument
        if (args.length != 2) {
            System.out.println("USAGE: java programname bashname");
            System.exit(1);
        }
        
        // create scanner that accesses file
        String programname = args[0]; // name of the program to translate to bash executable
	String bashname = args[1]; // name of bash executable generated by java
        FileInputStream programInStream = null;
        try {
            programInStream = new FileInputStream (programname);
        } catch (FileNotFoundException e) {
            System.out.println("ProgramToEcho: Unable to access file " + programname + ".");
            System.exit(1);
        }
        Scanner programScanner = new Scanner(programInStream);
        
        // create printer to write to file
        FileOutputStream bashOutStream = null;
        try {
            bashOutStream = new FileOutputStream(bashname);
        } catch (FileNotFoundException e) {
            System.out.println("ProgramToEcho: Unable to write to file " + bashname + ".");
        }
        PrintWriter bashPrinter = new PrintWriter(bashOutStream);
        bashPrinter.println("# !/bin/bash");
        bashPrinter.println("# this program echos " + programname);
        bashPrinter.println("");
        
        do {
            String line = programScanner.nextLine();
            line = line.replace("'", "\\\'");
            line = line.replace("\"","\\\"");
            line = line.replace("*","\'*\'");
            line = line.replace("%","\'%\'");
            line = line.replace("|","\'|\'");
            line = line.replace(">","\'>\'");
            line = line.replace("<","\'<\'");
            line = line.replace("&","\'&\'");
            line = line.replace("(", "\"(\"");
            line = line.replace(")","\")\"");
            line = line.replace("\t", "    ");
            line = line.replace(" ", "\' \'");
            bashPrinter.println("echo " + line);
        } while (programScanner.hasNextLine());
        
        programScanner.close();
        bashPrinter.close();
    }
}
