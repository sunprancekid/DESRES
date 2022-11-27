package edu.ncsu.csc216.wolf_tasks.model.notebook;

import java.io.File;

import edu.ncsu.csc216.wolf_tasks.model.io.NotebookWriter;
import edu.ncsu.csc216.wolf_tasks.model.tasks.AbstractTaskList;
import edu.ncsu.csc216.wolf_tasks.model.tasks.ActiveTaskList;
import edu.ncsu.csc216.wolf_tasks.model.tasks.Task;
import edu.ncsu.csc216.wolf_tasks.model.tasks.TaskList;
import edu.ncsu.csc216.wolf_tasks.model.util.ISortedList;
import edu.ncsu.csc216.wolf_tasks.model.util.SortedList;

/**
 * The Notebook class stores a list of several task lists, as well as an
 * additional list that has all of the active tasks that are in all of the task
 * lists.
 * 
 * @author Matthew A Dorsey (madorse2@ncsu.edu)
 *
 */
public class Notebook {

	/** name of notebook */
	private String notebookName;
	/** boolean that determines if notebook has been changed since last save */
	private boolean isChanged;
	/** list of task lists */
	private ISortedList<TaskList> taskLists;
	/** list of active tasks */
	private ActiveTaskList activeTaskList;
	/** list of current tasks */
	private AbstractTaskList currentTaskList;

	/**
	 * Constructs notebook object.
	 * 
	 * @param name name to assign to notebook.
	 * @throws IllegalArgumentException if name is null, empty, or has the same name
	 *                                  as the active task list.
	 */
	public Notebook(String name) {
		setNotebookName(name);
		setChange(true);
		taskLists = new SortedList<TaskList>();
		activeTaskList = new ActiveTaskList();
		setCurrentTaskList("");
	}

	/**
	 * sets name of notebook to value passed as a parameter
	 * 
	 * @param name name to set notebook name field to
	 * @throws IllegalArgumentException if name is null, empty, or has the same name
	 *                                  as the active task list.
	 */
	private void setNotebookName(String name) {
		if (name == null || "".equals(name) || ActiveTaskList.ACTIVE_TASKS_NAME.equals(name))
			throw new IllegalArgumentException("Invalid name.");
		notebookName = name;
	}

	/**
	 * returns value of notebook name field
	 * 
	 * @return a note book name
	 */
	public String getNotebookName() {
		return notebookName;
	}

	/**
	 * sets the value of the isChanged field
	 * 
	 * @param change boolean variable containing isChanged field
	 */
	public void setChange(boolean change) {
		isChanged = change;
	}

	/**
	 * returns the value of is changed field
	 * 
	 * @return the value of is changed field
	 */
	public boolean isChanged() {
		return isChanged;
	}

	/**
	 * Sets the currentTaskList to the AbstractTaskList with the given name. If a
	 * TaskList with that name is not found, then the currentTaskList is set to the
	 * activeTaskList.
	 * 
	 * @param taskListName string the specifies the task list to set to the current
	 *                     task list
	 */
	public void setCurrentTaskList(String taskListName) {
		currentTaskList = activeTaskList;
		for (int i = 0; i < taskLists.size(); i++) {
			if (taskLists.get(i).getTaskListName().equals(taskListName)) {
				currentTaskList = taskLists.get(i);
				break;
			}
		}
	}

	/**
	 * returns the current task list
	 * 
	 * @return the current task list
	 */
	public AbstractTaskList getCurrentTaskList() {
		return currentTaskList;
	}

	/**
	 * saves notebook to file specified as a parameter. isChaged field is update to
	 * false.
	 * 
	 * @param file location to store notebook's information
	 */
	public void saveNotebook(File file) {
		NotebookWriter.writeNotebookFile(file, notebookName, taskLists);
		setChange(false);
	}

	/**
	 * adds task list to list of task lists
	 * 
	 * @param taskList list of tasks
	 * @throws IllegalArgumentException if name of task list is the same as the
	 *                                  active task list, or is a duplicate of a
	 *                                  task list that is already in the list of
	 *                                  task lists.
	 */
	public void addTaskList(TaskList taskList) {
		// determine that the task list has the correct title
		if (checkTaskListName(taskList.getTaskListName()))
			throw new IllegalArgumentException("Invalid name.");

		// add the task list to the task lists
		taskLists.add(taskList);
		getActiveTaskList();
		setCurrentTaskList(taskList.getTaskListName());
		setChange(true);
	}

	/**
	 * returns array of strings containing the names of all task lists in the
	 * notebook. The active task list is always first
	 * 
	 * @return array of strings containing the names of all task lists
	 */
	public String[] getTaskListsNames() {
//		String[] listNames = new String[taskLists.size() + 1];
//		listNames[listNames.length - 1] = activeTaskList.getTaskListName();
//		for (int i = 0; i < listNames.length - 1; i++) {
//			listNames[i] = taskLists.get(i).getTaskListName();
//		}
//		return listNames;

		String[] listNames = new String[taskLists.size() + 1];
		listNames[0] = activeTaskList.getTaskListName();
		for (int i = 1; i < listNames.length; i++) {
			listNames[i] = taskLists.get(i - 1).getTaskListName();
		}
		return listNames;
	}

	/**
	 * private method used for building the list of active tasks
	 */
	private void getActiveTaskList() {
		activeTaskList = new ActiveTaskList();
		for (int i = 0; i < taskLists.size(); i++) {
			for (int j = 0; j < taskLists.get(i).getTasks().size(); j++) {
				if (taskLists.get(i).getTasks().get(j).isActive())
					activeTaskList.addTask(taskLists.get(i).getTasks().get(j));
			}
		}
	}

	/**
	 * Private helper method that determines if the name of a task list is equal to
	 * the active task list name or the name of any of the task lists current stored
	 * within the notebook.
	 * 
	 * @param taskListName name of the task list
	 * @return true if the task list name matches the active task list name or the
	 *         name of any of the task lists current store in the notebook.
	 */
	private boolean checkTaskListName(String taskListName) {
		// determine that the task list has the correct title
		boolean checkTitle = taskListName.equalsIgnoreCase(ActiveTaskList.ACTIVE_TASKS_NAME);
		for (int i = 0; i < taskLists.size(); i++) {
			checkTitle = checkTitle || taskLists.get(i).getTaskListName().equalsIgnoreCase(taskListName);
		}
		return checkTitle;
	}

	/**
	 * Updates the name of current task list.
	 * 
	 * @param taskListName name of the task list
	 * @throws IllegalArgumentException if the current task list is the active task
	 *                                  list, and if the name of the task list is
	 *                                  the same as the abstract task list or is a
	 *                                  duplicate of another task list already in
	 *                                  the list.
	 */
	public void editTaskList(String taskListName) {
		if (currentTaskList == activeTaskList) {
			throw new IllegalArgumentException("The Active Tasks list may not be edited.");

		}

		// determine that the task list has the correct title
		if (checkTaskListName(taskListName))
			throw new IllegalArgumentException("Invalid name.");

		// update the name of the current task list
		currentTaskList.setTaskListName(taskListName);
		TaskList currentTaskList2 = (TaskList) currentTaskList;

		removeTaskList();
		addTaskList(currentTaskList2);
		isChanged = true;
	}

	/**
	 * Removes the current task list from the list of task lists.
	 * 
	 * @throws IllegalArgumentException if the current task list is the active task
	 *                                  list
	 */
	public void removeTaskList() {
		if (currentTaskList == activeTaskList)
			throw new IllegalArgumentException("The Active Tasks list may not be deleted.");

		// find the active task list and remove it
		for (int i = 0; i < taskLists.size(); i++) {
			if (taskLists.get(i).getTaskListName().equals(currentTaskList.getTaskListName())) {
				taskLists.remove(i);
				break;
			}
		}
		setCurrentTaskList("");
		isChanged = true;
	}

	/**
	 * Adds a task to the current task list
	 * 
	 * @param t task to add to current task list
	 */
	public void addTask(Task t) {
		if (currentTaskList instanceof TaskList) {
			currentTaskList.addTask(t);
			if (t.isActive())
				getActiveTaskList();
			isChanged = true;
		}
	}

	/**
	 * Updates the fields of a task in the currentTaskList. If the currentTaskList
	 * is the activeTaskList, not action is taken.
	 * 
	 * @param idx             integer specifying the location of the task whose
	 *                        fields will be updated
	 * @param taskName        new task name assigned to task
	 * @param taskDescription new task description to assign to task
	 * @param recurring       new task recurring designation to assign to task
	 * @param active          new task active designation to assign to task
	 */
	public void editTask(int idx, String taskName, String taskDescription, boolean recurring, boolean active) {
		if (currentTaskList != activeTaskList) {
			currentTaskList.getTask(idx).setTaskName(taskName);
			currentTaskList.getTask(idx).setTaskDescription(taskDescription);
			currentTaskList.getTask(idx).setRecurring(recurring);
			currentTaskList.getTask(idx).setActive(active);
			getActiveTaskList();
			isChanged = true;
		}
	}

}
