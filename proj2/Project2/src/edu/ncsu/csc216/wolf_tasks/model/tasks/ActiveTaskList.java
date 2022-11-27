/**
 * 
 */
package edu.ncsu.csc216.wolf_tasks.model.tasks;

import edu.ncsu.csc216.wolf_tasks.model.util.ISwapList;

/**
 * The class ActiveTaskList extends AbstractTaskList. This class holds the
 * active tasks in a SwapList interface.
 * 
 * @author mauro
 *
 */
public class ActiveTaskList extends AbstractTaskList {

	/**
	 * Constant for holding the name of the Active Tasks
	 */
	public static final String ACTIVE_TASKS_NAME = "Active Tasks";

	/**
	 * Constructs the ActiveTaskList with the active task name
	 */
	public ActiveTaskList() {
		super(ACTIVE_TASKS_NAME, 0);

	}

	/**
	 * This method override the addTask in the parent class to check that the Task
	 * is active before adding to the end of the IswapList.
	 * 
	 * @param t task object
	 * 
	 * @throws IllegalArgumentException if the task is not active
	 */
	@Override
	public void addTask(Task t) {
		if (!t.isActive()) {
			throw new IllegalArgumentException("Cannot add task to Active Tasks.");
		}
		getTasks().add(t);
		t.addTaskList(this);
	}

	/**
	 * This method check override the setTaskListName in the parent class to ensure
	 * that the paramter value matchesthe expected name
	 * 
	 * @param taskListName the name of the task list
	 * @throws IllegalArgumentException if the name is not set.
	 */
	@Override
	public void setTaskListName(String taskListName) {
		if (!ACTIVE_TASKS_NAME.equals(taskListName)) {
			throw new IllegalArgumentException("The Active Tasks list may not be edited.");
		}
		super.setTaskListName(taskListName);
	}

	/**
	 * This method remove all the ActiveTaskList of all tasks
	 */
	public void clearTasks() {
		ISwapList<Task> tasks = getTasks();
		// int i=0;
		while (tasks.size() > 0) {
			completeTask(tasks.get(0));
			// i++;
		}

//		for (int i = 0; i < tasks.size(); i++) {
//			completeTask(tasks.get(i));
//		}

	}

	/**
	 * This method returns a 2D String array where the first column is the name of
	 * the TaskList that the Task belongs to and the name of the Task
	 */
	@Override
	public String[][] getTasksAsArray() {
		ISwapList<Task> tasks = getTasks();
		String[][] array = new String[tasks.size()][2];
		for (int i = 0; i < tasks.size(); i++) {
			array[i][0] = tasks.get(i).getTaskListName();
			array[i][1] = tasks.get(i).getTaskName();
		}
		return array;

	}
}
