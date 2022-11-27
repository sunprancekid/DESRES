package edu.ncsu.csc216.wolf_tasks.model.io;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

import edu.ncsu.csc216.wolf_tasks.model.notebook.Notebook;
import edu.ncsu.csc216.wolf_tasks.model.tasks.AbstractTaskList;
import edu.ncsu.csc216.wolf_tasks.model.tasks.ActiveTaskList;
import edu.ncsu.csc216.wolf_tasks.model.tasks.Task;
import edu.ncsu.csc216.wolf_tasks.model.tasks.TaskList;

/**
 * This class is used to read a notebook from a file. it has one public method
 * readNotebookFile that receives a File with the file to read from.
 * 
 * @author mauro
 *
 */
public class NotebookReader {
 

	/**
	 * 
	 * This method recieve a file with all the notebooks to read from. The input
	 * file contains a single notebook. Each notebook can have zero to many task
	 * lists. Each task list can have zero to many tasks.
	 * 
	 * @param fileName name of the file
	 * @return a notebook
	 * @throws IllegalArgumentException if the file does not exsist.
	 */
	public static Notebook readNotebookFile(File fileName) {

		Notebook ntb = null;
		try {

			Scanner scnr = new Scanner(fileName);
			String string = "";
			// read the whole file into the String object, line by line
			while (scnr.hasNext()) {
				string += "\n" + scnr.nextLine();
			}
			scnr.close();
			// Check If the first character is not ! \\r?\\n?[*]
			if (!string.substring(0, 2).equals("\n!")) {
				throw new IllegalArgumentException("Unable to load file.");
			}

			String[] escSplit = string.split("\n! ");
			String[] hashSplit = escSplit[1].split("\n# ");
			// notebook name
			ntb = new Notebook(hashSplit[0]);
			for (int i = 1; i < hashSplit.length; i++) {
				String[] starSplit = hashSplit[i].split("\n\\* ");

				try {
					TaskList taskList = processTaskList(starSplit[0]);
					for (int j = 1; j < starSplit.length; j++) {

						try {
							Task task = processTask(taskList, starSplit[j]);
							taskList.addTask(task);
						} catch (Exception e) {
							System.out.println();
						}

					}
					ntb.addTaskList(taskList);
				} catch (Exception e) {
					System.out.println();
				}

			}

		} catch (FileNotFoundException e) {
			throw new IllegalArgumentException("Unable to load file.");
		}

	ntb.setCurrentTaskList(ActiveTaskList.ACTIVE_TASKS_NAME);
		return ntb;

	}

	/**
	 * Helper method that creates and returns a list based on a String
	 * 
	 * @param listName name of the list
	 * @return the created list
	 */
	private static TaskList processTaskList(String listName) {
		// System.out.println("\n*********" + listName);
		String[] comaSplit = listName.split(",");

		return new TaskList(comaSplit[0], Integer.parseInt(comaSplit[1]));
	}

	/**
	 * Helper method that creates a task based on string information. Assigns it to
	 * a task list.
	 * 
	 * @param taskList   that contains a task
	 * @param taskString string information of the task
	 * @return a created task
	 */
	private static Task processTask(AbstractTaskList taskList, String taskString) {
		boolean recurring = false;
		boolean active = false;
		String[] lineSplit = taskString.split("\n");
		String[] sizeSplit = lineSplit[0].split(",");

		for (int i = 1; i < sizeSplit.length; i++) {
			switch (sizeSplit[i]) {
			case "recurring":
				recurring = true;
				break;
			case "active":
				active = true;
				break;
			default:
				throw new IllegalArgumentException();
			} 
		}
 
		// add desctiption
		String description = "";
		for (int i = 1; i < lineSplit.length - 1; i++) {
			description += lineSplit[i] + "\n";
		}
		description += lineSplit[lineSplit.length - 1];
		Task task = new Task(sizeSplit[0], description, recurring, active);
		task.addTaskList(taskList);

		return task;
	}



}
