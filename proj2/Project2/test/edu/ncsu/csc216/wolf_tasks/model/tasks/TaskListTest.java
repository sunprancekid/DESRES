package edu.ncsu.csc216.wolf_tasks.model.tasks;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class TaskListTest {

	@Test
	final void testGetTasksAsArray() {
		// create tasks
		Task t1 = new Task("task1", "task1 description", false, false);
		Task t2 = new Task("task2", "task2 description", true, false);
		Task t3 = new Task("task3", "task3 description", false, true);
		Task t4 = new Task("task4", "task4 description", true, true);
		
		// create task list and add tasks
		TaskList taskList = new TaskList("Task List", 0);
		taskList.addTask(t1);
		taskList.addTask(t2);
		taskList.addTask(t3);
		taskList.addTask(t4);
		
		// generate the task list as an array and check the array
		String[][] taskListAsArray = taskList.getTasksAsArray();
		assertEquals(4, taskListAsArray.length);
		assertEquals("1", taskListAsArray[0][0]);
		assertEquals("task1", taskListAsArray[0][1]);
		assertEquals("2", taskListAsArray[1][0]);
		assertEquals("task2", taskListAsArray[1][1]);
		assertEquals("3", taskListAsArray[2][0]);
		assertEquals("task3", taskListAsArray[2][1]);
		assertEquals("4", taskListAsArray[3][0]);
		assertEquals("task4", taskListAsArray[3][1]);
	}

	@Test
	final void testCompareTo() {
		// create two different task lists
		TaskList tl1 = new TaskList("First TaskList", 0);
		TaskList tl2 = new TaskList("Second TaskList", 0);
		
		// compare the task lists
		assertTrue(tl1.compareTo(tl2) < 0);
		assertTrue(tl2.compareTo(tl1) > 0);
	}

}
