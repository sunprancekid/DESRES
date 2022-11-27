/**
 * 
 */
package edu.ncsu.csc216.wolf_tasks.model.tasks;

import edu.ncsu.csc216.wolf_tasks.model.util.ISwapList;

/**
 * This class Extends AbstractTaskList and implements the Comparable interface,
 * and it is used to create a tasklist.
 * 
 * @author Matthew A Dorsey (madorse2@ncsu.edu)
 *
 */
public class TaskList extends AbstractTaskList implements Comparable<TaskList> {

	/**
	 * Constructs TaskList object using abstract task list constructor.
	 * 
	 * @param taskListName   String containing name of task list
	 * @param completedCount integer containing number of tasks that the TaskList
	 *                       has completed.
	 * 
	 */
	public TaskList(String taskListName, int completedCount) {
		super(taskListName, completedCount);
	}

	/**
	 * Returns a 2D String array where the first column is the priority of the Task,
	 * starting at 1, and the name of the Task.
	 * 
	 * @return a 2D String array
	 */
	public String[][] getTasksAsArray() {
		ISwapList<Task> tasks = getTasks();
		String[][] array = new String[tasks.size()][2];
		for (int i = 0; i < tasks.size(); i++) {
			array[i][0] = String.valueOf(i + 1);
			array[i][1] = tasks.get(i).getTaskName();
		}
		return array;
	}

	/**
	 * Compares the names of the TaskLists.
	 * 
	 * @return an integer value compared from ASCII (-1 if the name of this task
	 *         list is < of the name of the list o, 1 if it is >, 0 if it =)
	 * 
	 */
	@Override
	public int compareTo(TaskList o) {
		return getTaskListName().compareTo(o.getTaskListName());
	}

}
