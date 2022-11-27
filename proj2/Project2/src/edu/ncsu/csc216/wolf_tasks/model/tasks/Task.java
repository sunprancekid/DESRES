/**
 * 
 */
package edu.ncsu.csc216.wolf_tasks.model.tasks;

import edu.ncsu.csc216.wolf_tasks.model.util.ISwapList;
import edu.ncsu.csc216.wolf_tasks.model.util.SwapList;

/**
 * The Task class contains the information about each individual task including
 * the taskName , taskDescription ,if the task is recurring , and if the task is
 * active .
 * 
 * @author mauro
 *
 */
public class Task implements Cloneable {

	// **********
	// * FIELDS *
	// **********

	/**
	 * Name of the task
	 */
	private String taskName;

	/**
	 * Description of the task
	 */
	private String taskDescription;

	/**
	 * Recurring task
	 */
	private boolean recurring;

	/**
	 * active task
	 */
	private boolean active;

	/**
	 * task list where the current task belong
	 */
	private ISwapList<AbstractTaskList> taskLists;

	// ***************
	// * CONSTRUCTOR *
	// ***************

	/**
	 * Constructor for a task
	 * 
	 * @param taskName    name of the task
	 * @param taskDetails details of the task
	 * @param recurring   status of the task
	 * @param active      status of the task
	 */
	public Task(String taskName, String taskDetails, boolean recurring, boolean active) {

		setTaskName(taskName);
		setTaskDescription(taskDetails);
		taskLists = new SwapList<AbstractTaskList>();
		setRecurring(recurring);
		setActive(active);
	}

	/**
	 * Access the name of the task
	 * 
	 * @return the name of the task
	 */
	public String getTaskName() {
		return taskName;

	}

	/**
	 * Access the description of the task
	 * 
	 * @return the taskDescription
	 */
	public String getTaskDescription() {
		return taskDescription;
	}

	/**
	 * Check if the task is in recurring status
	 * 
	 * @return the recurring status of the task
	 */
	public boolean isRecurring() {
		return recurring;
	}

	/**
	 * Confirms that the task is in the recurring status
	 * 
	 * @param recurring status of the task
	 */
	public void setRecurring(boolean recurring) {
		this.recurring = recurring;
	}

	/**
	 * Check if the task is in active status
	 * 
	 * @return the active status of the task
	 */
	public boolean isActive() {
		return active;
	}

	/**
	 * Confirms that the task is in the active status
	 * 
	 * @param active status of the task
	 */
	public void setActive(boolean active) {
		this.active = active;
	}

	/**
	 * Changes the name of the task.
	 * 
	 * @param taskName the taskName to set
	 */
	public void setTaskName(String taskName) {
		if ("".equals(taskName) || " ".equals(taskName) || taskName == null) {
			throw new IllegalArgumentException("Incomplete task information.");
		}

		this.taskName = taskName;

	}

	/**
	 * Changes the description of the task.
	 * 
	 * @param taskDescription the taskDescription to set
	 */
	public void setTaskDescription(String taskDescription) {
		if ("".equals(taskDescription) || taskDescription == null) {
			throw new IllegalArgumentException("Incomplete task information.");
		}
		this.taskDescription = taskDescription;
	}

	/**
	 * Access the task list names
	 * 
	 * @return null
	 */
	public String getTaskListName() {

		if (taskLists == null || taskLists.size() == 0) {
			return "";
		}
		return taskLists.get(0).getTaskListName();

	}

	/**
	 * Add a task to the list
	 * 
	 * @param taskList of task to add
	 */
	public void addTaskList(AbstractTaskList taskList) {

		if (taskList == null) {
			throw new IllegalArgumentException("Incomplete task information.");
		}
		boolean taskListExist = false;

		for (int i = 0; i < taskLists.size(); i++) {
			if (taskLists.get(i) == taskList) {
				taskListExist = true;
				break;
			}
		}

		if (!taskListExist) {
			taskLists.add(taskList);
		}
	}

	/**
	 * Completes a task by notifyiing the list containing this task to delete it. If
	 * the task is recurring, it is clones and added to the list.
	 * 
	 * @throws IllegalArgumentExcpetion if the task cannot be cloned
	 */
	public void completeTask() {
		Task clone = null;
		try {
			clone = (Task) clone();
		} catch (CloneNotSupportedException e) {
			throw new IllegalArgumentException("Task cannot be cloned.");
		}
		for (int i = 0; i < taskLists.size(); i++) {
			taskLists.get(i).completeTask(this);
		}
		if (recurring) {
			for (int i = 0; i < taskLists.size(); i++) {
				taskLists.get(i).addTask(clone);
			}
		}
	}

	/**
	 * Creates and clone a new Task with all the fields
	 * 
	 * @return the cloned task
	 * @throws CloneNotSupportedException if there are no AbstractTaskLists
	 *                                    registered with the Task
	 */

	public Object clone() throws CloneNotSupportedException {

		if (taskLists.size() == 0) {
			throw new CloneNotSupportedException("Cannot clone.");
		}
		// SwapList<AbstractTaskList> taskListCopy = new SwapList<AbstractTaskList>();
		// cloning the list

		Task copy = new Task(new String(taskName), new String(taskDescription), recurring, active);
		for (int i = 0; i < taskLists.size(); i++) {
			copy.addTaskList(taskLists.get(i));
		}
		return copy;

	}

	/**
	 * Converts the task object to a string
	 * 
	 * @return String description of
	 */
	@Override
	public String toString() {

		String s = "* " + taskName;

		if (recurring && active) {
			s += ",recurring,active";
		} else if (recurring) {
			s += ",recurring";
		} else if (active) {
			s += ",active";
		}
		s += "\n" + taskDescription;
		return s;

	}
}
