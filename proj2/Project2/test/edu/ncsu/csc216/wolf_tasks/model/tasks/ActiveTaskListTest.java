package edu.ncsu.csc216.wolf_tasks.model.tasks;

import static org.junit.Assert.assertThrows;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class ActiveTaskListTest {

	@Test
	final void testSetTaskListName() {
		ActiveTaskList tskList = new ActiveTaskList();
		Exception e = assertThrows(IllegalArgumentException.class, () -> tskList.setTaskListName("New Name"));
		assertEquals("The Active Tasks list may not be edited.", e.getMessage());
	}

	@Test
	final void testAddTask() {
		ActiveTaskList tskList = new ActiveTaskList();
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		Task task2 = assertDoesNotThrow(() -> new Task("New Name", "New Task Detail", false, false));
		tskList.addTask(task);
		assertEquals(task, tskList.getTask(0));
		Exception e = assertThrows(IllegalArgumentException.class, () -> tskList.addTask(task2));
		assertEquals("Cannot add task to Active Tasks.", e.getMessage());
	}

	@Test
	final void testGetTasksAsArray() {
		ActiveTaskList activeTaskList = new ActiveTaskList();
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		Task task2 = assertDoesNotThrow(() -> new Task("New Name", "New Task Detail", true, true));
		TaskList tasklist = new TaskList("My list", 0);
		tasklist.addTask(task);
		activeTaskList.addTask(task);
		activeTaskList.addTask(task2);
		String[][] array = activeTaskList.getTasksAsArray();
		assertEquals("My list", array[0][0]);
		assertEquals("Task Name", array[0][1]);
		assertEquals(ActiveTaskList.ACTIVE_TASKS_NAME, array[1][0]);
		assertEquals("New Name", array[1][1]);
	}

	@Test
	final void testActiveTaskList() {
		ActiveTaskList tskList = new ActiveTaskList();
		assertEquals(ActiveTaskList.ACTIVE_TASKS_NAME, tskList.getTaskListName());
		assertEquals(0, tskList.getCompletedCount());
	}

	@Test
	final void testClearTasks() {
		ActiveTaskList tskList = new ActiveTaskList();
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		Task task2 = assertDoesNotThrow(() -> new Task("New Name", "New Task Detail", true, true));
		tskList.addTask(task);
		tskList.addTask(task2);
	
	assertEquals(2, tskList.getTasksAsArray().length);
	tskList.clearTasks();
	assertEquals(0, tskList.getTasksAsArray().length);
	}

}
