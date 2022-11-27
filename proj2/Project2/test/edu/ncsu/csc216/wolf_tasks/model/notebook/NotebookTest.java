package edu.ncsu.csc216.wolf_tasks.model.notebook;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;

import org.junit.jupiter.api.Test;

import edu.ncsu.csc216.wolf_tasks.model.tasks.ActiveTaskList;
import edu.ncsu.csc216.wolf_tasks.model.tasks.Task;
import edu.ncsu.csc216.wolf_tasks.model.tasks.TaskList;

class NotebookTest {

	/**
	 * Test the construction of notebook objects
	 */
	@Test
	final void testNotebookConstruction() {
		// construct a notebook
		Notebook notebook = new Notebook("notebook");

		// check that the fields have been generated properly
		assertEquals("notebook", notebook.getNotebookName());
		assertTrue(notebook.isChanged());
		assertEquals(0, notebook.getCurrentTaskList().getTasks().size());

		// creating a notebook with a name that is null, an empty string or is the same
		// as the active task list should throw an exception
		assertThrows(IllegalArgumentException.class, () -> new Notebook(""));
		assertThrows(IllegalArgumentException.class, () -> new Notebook(null));
		assertThrows(IllegalArgumentException.class, () -> new Notebook(ActiveTaskList.ACTIVE_TASKS_NAME));
	}

	/**
	 * Test adding task lists to the notebook
	 */
	@Test
	final void testNotebookTaskLists() {
		// construct a notebook
		Notebook nb = new Notebook("nb");

		// create tasks and task lists
		Task tl1t1 = new Task("Task List 1 Task 1", "description", true, false);
		Task tl1t2 = new Task("Task List 1 Task 2", "description", false, false);
		Task tl2t1 = new Task("Task List 2 Task 1", "description", false, true);
		Task tl2t2 = new Task("Task List 2 Task 2", "description", true, true);
		TaskList tl1 = new TaskList("Task List 1", 0);
		TaskList tl2 = new TaskList("Task List 2", 0);
		tl1.addTask(tl1t1);
		tl1.addTask(tl1t2);
		tl2.addTask(tl2t1);
		tl2.addTask(tl2t2);

		// add task lists to the notebook
		assertDoesNotThrow(() -> nb.addTaskList(tl1));
		assertSame(nb.getCurrentTaskList(), tl1);
		assertDoesNotThrow(() -> nb.addTaskList(tl2));
		assertSame(nb.getCurrentTaskList(), tl2);

		// adding a task list with an invalid name or the same name as a task list
		// already in the notebook throws an exception
		TaskList invalidTl1 = new TaskList(ActiveTaskList.ACTIVE_TASKS_NAME, 0);
		assertThrows(IllegalArgumentException.class, () -> nb.addTaskList(invalidTl1));
		TaskList incalidTl2 = new TaskList("Task List 1", 0);
		assertThrows(IllegalArgumentException.class, () -> nb.addTaskList(incalidTl2));

		// change the name of a task list and confirm that the name has changed
		String[] taskListNames = nb.getTaskListsNames();
		assertEquals(ActiveTaskList.ACTIVE_TASKS_NAME, taskListNames[0]);
		assertEquals("Task List 1", taskListNames[1]);
		assertEquals("Task List 2", taskListNames[2]);
		nb.editTaskList("Task List 3");
		taskListNames = nb.getTaskListsNames();
		assertEquals(ActiveTaskList.ACTIVE_TASKS_NAME, taskListNames[0]);
		assertEquals("Task List 1", taskListNames[1]);
		assertEquals("Task List 3", taskListNames[2]);

		// an exception is thrown if the task list is changed to an invalid name
		assertThrows(IllegalArgumentException.class, () -> nb.editTaskList(ActiveTaskList.ACTIVE_TASKS_NAME));
		assertThrows(IllegalArgumentException.class, () -> nb.editTaskList("Task List 1"));

		// add a task to a task list in the notebook
		Task task1 = new Task("Task List 1 Task 1", "description", true, true);
		nb.addTask(task1);

		// edit a task in a task list in the notebook
		nb.editTask(1, "Task1", "description 1", true, true);

		// remove the task lists from the notebook
		nb.removeTaskList();
		taskListNames = nb.getTaskListsNames();
		assertEquals(ActiveTaskList.ACTIVE_TASKS_NAME, taskListNames[0]);
		assertEquals("Task List 1", taskListNames[1]);

		// if the current task list is the active task list, the list cannot be removed
		// or edited
		assertThrows(IllegalArgumentException.class, () -> nb.editTaskList("Another Task List??"));
		assertThrows(IllegalArgumentException.class, () -> nb.removeTaskList());

		// saveNotebook file

		nb.saveNotebook(new File("test-files/output.txt"));
	}

//	@Test
//	final void testAdditional() {
//		Notebook nb = new Notebook("nb");
//		TaskList taskList1 = new TaskList("TaskList1", 0);
//		nb.addTaskList(taskList1);
//		TaskList aTaskList = new TaskList("ATaskList", 0);
//		nb.addTaskList(aTaskList);
//		TaskList middleTaskList = new TaskList("MiddleTaskList", 0);
//		nb.addTaskList(middleTaskList);
//		TaskList zZZTaskList = new TaskList("ZZZTaskList", 0);
//		nb.addTaskList(zZZTaskList);
//		String[] list = nb.getTaskListsNames();
//
//		for (int i = 0; i < list.length; i++) {
//			System.out.println(list[i]);
//		}
//		assertThrows(IllegalArgumentException.class, () -> nb.editTaskList(ActiveTaskList.ACTIVE_TASKS_NAME));
//
//		assertThrows(IllegalArgumentException.class, () -> nb.editTaskList("MiddleTaskList"));
//		assertThrows(IllegalArgumentException.class, () -> nb.editTaskList("ZZZTaskList"));
//		// assertThrows(IllegalArgumentException.class, () ->
//		// nb.editTaskList("BTaskList"));
//		System.out.println();
//		nb.editTaskList("BTaskList");
//		String[] list1 = nb.getTaskListsNames();
//
//		for (int i = 0; i < list1.length; i++) {
//			System.out.println(list1[i]);
//		}
//	}
}
