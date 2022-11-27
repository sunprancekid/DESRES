/**
 * 
 */
package edu.ncsu.csc216.wolf_tasks.model.tasks;

import edu.ncsu.csc216.wolf_tasks.model.util.ISwapList;
import edu.ncsu.csc216.wolf_tasks.model.util.SwapList;

/**
 * This class represents a task list in the WolfTask system
 * 
 * @author mauro
 *
 */
public abstract class AbstractTaskList {

	// **********
	// * FIELDS *
	// **********

	/**
	 * name of the task list
	 */
	private String taskListName;

	/**
	 * Counter for completed tasks
	 */
	private int completedCount;

	/**
	 * variable holding the task
	 */
	private ISwapList<Task> tasks;

	// ***************
	// * CONSTRUCTOR *
	// ***************

	/**
	 * The Constructor sets the fields from the parameters andconstructs a SwapList
	 * for the Task s
	 * 
	 * @param taskListName   name of the task list
	 * @param completedCount Counter for completed tasks
	 */
	public AbstractTaskList(String taskListName, int completedCount) {

		setTaskListName(taskListName);

		if (completedCount < 0) {
			throw new IllegalArgumentException("Invalid completed count.");
		}
		this.completedCount = completedCount;
		tasks = new SwapList<Task>();
	}

	/**
	 * Get the task list name
	 * 
	 * @return the task list name
	 */
	public String getTaskListName() {
		return taskListName;

	}

	/**
	 * Change the task list name
	 * 
	 * @param taskListName the task list name
	 */
	public void setTaskListName(String taskListName) {
		if (taskListName == null || "".equals(taskListName)) {
			throw new IllegalArgumentException("Invalid name.");

		}
		this.taskListName = taskListName;
	}

	/**
	 * get a list of tasks
	 * 
	 * @return task list
	 */
	public ISwapList<Task> getTasks() {
		return tasks;

	}

	/**
	 * get the number of completed tasks
	 * 
	 * @return the completed count
	 */
	public int getCompletedCount() {
		return completedCount;

	}

	/**
	 * add a new task to the list
	 * 
	 * @param task to be added
	 */
	public void addTask(Task task) {

		tasks.add(task);
		task.addTaskList(this);
	}

	/**
	 * remove a task from the list
	 * 
	 * @param idx of the task
	 * @return the dleeted task
	 */
	public Task removeTask(int idx) {
		// get the task
		Task task = tasks.get(idx);
		// delete the task
		tasks.remove(idx);

		return task;

	}

	/**
	 * retrive a task from the list
	 * 
	 * @param idx idx of the task
	 * @return the dleeted task
	 */
	public Task getTask(int idx) {

		return tasks.get(idx);

	}

	/**
	 * Rectrives a complete task from the list and removes it, and increase the
	 * counter
	 * 
	 * @param t to be completed
	 */
	public void completeTask(Task t) {

		for (int i = 0; i < tasks.size(); i++) {
			if (tasks.get(i) == t) {
				removeTask(i);
				break;
			}

		}
		completedCount++;
	}

	/**
	 * An abstract method that returns a 2D String array. The contents of the array
	 * are left forthe child classes to define.
	 * 
	 * @return a 2D String array
	 */
	public abstract String[][] getTasksAsArray();

}