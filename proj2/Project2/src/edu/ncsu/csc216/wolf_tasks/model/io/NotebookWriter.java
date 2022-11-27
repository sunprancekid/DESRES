package edu.ncsu.csc216.wolf_tasks.model.io;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

import edu.ncsu.csc216.wolf_tasks.model.tasks.TaskList;
import edu.ncsu.csc216.wolf_tasks.model.util.ISortedList;

/**
 * The NotebookWriter class is used to write the contents of a notebook to a
 * file in a way that, later, the exact contents of the notebook can be
 * recreated using the NotebookReader class.
 * 
 * @author Matthew A Dorsey (madorse2@ncsu.edu)
 *
 */
public class NotebookWriter {

	/**
	 * Method that saves the contents of a notebook to an external file
	 * 
	 * @param file     name of file to save contents of notebook to
	 * @param title    title of notebook
	 * @param taskList sorted list of task lists
	 */
	public static void writeNotebookFile(File file, String title, ISortedList<TaskList> taskList) {
		// establish output stream to file
		FileOutputStream outStream = null;
		try {
			outStream = new FileOutputStream(file);
		} catch (IOException e) {
			throw new IllegalArgumentException("Unable to save file.");
		}
		PrintWriter outPrinter = new PrintWriter(outStream);

		outPrinter.println("! " + title);
		for (int i = 0; i < taskList.size(); i++) {
			TaskList currentTaskList = taskList.get(i);
			outPrinter.println("# " + currentTaskList.getTaskListName() + ","
					+ Integer.toString(currentTaskList.getCompletedCount()));
			for (int j = 0; j < currentTaskList.getTasks().size(); j++) {
				outPrinter.println(currentTaskList.getTask(j).toString());
			}
		}
		outPrinter.close();
	}

}
