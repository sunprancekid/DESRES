package edu.ncsu.csc216.wolf_tasks.model.io;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import org.junit.jupiter.api.Test;

import edu.ncsu.csc216.wolf_tasks.model.tasks.Task;
import edu.ncsu.csc216.wolf_tasks.model.tasks.TaskList;
import edu.ncsu.csc216.wolf_tasks.model.util.ISortedList;
import edu.ncsu.csc216.wolf_tasks.model.util.SortedList;

class NotebookWriterTest {

	@Test
	void testWriteIssuesToFile() {
		// create task lists 
		TaskList tl1 = new TaskList("ATaskList", 0);
		TaskList tl2 = new TaskList("Tasks1", 0);
		Task tl2t1 = new Task("Task1", "Task1Description", true, false);
		Task tl2t2 = new Task("Task2", "Task2Description", true, true);
		tl2.addTask(tl2t1);
		tl2.addTask(tl2t2);
		TaskList tl3 = new TaskList("Tasks2", 0);
		Task tl3t1 = new Task("Task3", "Task3Description", false, false);
		Task tl3t2 = new Task("Task4", "Task4Description", false, true);
		Task tl3t3 = new Task("Task5", "Task5Description", true, false);
		tl3.addTask(tl3t1);
		tl3.addTask(tl3t2);
		tl3.addTask(tl3t3);
		// create array of task lists for file writing
		ISortedList<TaskList> taskList = new SortedList<TaskList>(); 
		taskList.add(tl1);
		taskList.add(tl2);
		taskList.add(tl3);
		// write the task list to a file
		File file = new File("test-files/actual_out.txt");
		NotebookWriter.writeNotebookFile(file, "Notebook", taskList);
		// check that the files are equivalent
		assertTrue(checkFiles("test-files/expected_out.txt", "test-files/actual_out.txt"));
	
	}

	/**
	 * Helper method to compare two files for the same contents
	 * 
	 * @param expFile expected output
	 * @param actFile actual output
	 * @return true if files match, else false
	 */
	private boolean checkFiles(String expFile, String actFile) {
		try (Scanner expScanner = new Scanner(new File(expFile));
				Scanner actScanner = new Scanner(new File(actFile));) {

			while (expScanner.hasNextLine()) {
				assertEquals(expScanner.nextLine(), actScanner.nextLine());
			}

			expScanner.close();
			actScanner.close();
			return true;
		} catch (IOException e) {
			fail(expFile + " does not match " + actFile);
			return false;
		}
	}

}
