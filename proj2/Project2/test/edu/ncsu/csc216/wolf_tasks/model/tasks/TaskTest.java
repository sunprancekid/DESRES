/**
 * 
 */
package edu.ncsu.csc216.wolf_tasks.model.tasks;

import static org.junit.Assert.assertThrows;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

/**
 * The TaskTest class tests the Task class.
 * @author mauro
 *
 */
class TaskTest {

	/**
	 * Test method for
	 * {@link edu.ncsu.csc216.wolf_tasks.model.tasks.Task#Task(java.lang.String, java.lang.String, boolean, boolean)}.
	 */
	@Test
	final void testTask() {
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		// testing getters - removed the methods
		assertEquals("Task Name", task.getTaskName());
		assertEquals("Task Detail", task.getTaskDescription());
		assertTrue(task.isRecurring());
		assertTrue(task.isActive());
		assertEquals("", task.getTaskListName());
		// testing setters
		// testing incorrect task name
		Exception e = assertThrows(IllegalArgumentException.class, () -> new Task("", "task detail", true, true));
		assertEquals("Incomplete task information.", e.getMessage());
		// testing incorrect task description
		Exception e1 = assertThrows(IllegalArgumentException.class, () -> new Task("Task Name", "", true, true));
		assertEquals("Incomplete task information.", e1.getMessage());

	}

	/**
	 * Test method for
	 * {@link edu.ncsu.csc216.wolf_tasks.model.tasks.Task#addTaskList(edu.ncsu.csc216.wolf_tasks.model.tasks.AbstractTaskList)}.
	 */
	@Test
	final void testAddTaskList() {
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		TaskList taskList = assertDoesNotThrow(() -> new TaskList("School", 0));
		task.addTaskList(taskList);
		assertEquals("School", task.getTaskListName());
	}

	/**
	 * Test method for
	 * {@link edu.ncsu.csc216.wolf_tasks.model.tasks.Task#completeTask()}.
	 * 
	 * @throws CloneNotSupportedException if task cannot be cloned
	 */
	@Test
	final void testCompleteTask() throws CloneNotSupportedException {
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		TaskList taskList1 = assertDoesNotThrow(() -> new TaskList("School", 0));
		TaskList taskList2 = assertDoesNotThrow(() -> new TaskList("Work", 0));

		taskList1.addTask(task);
		assertEquals(1, taskList1.getTasks().size());

		taskList2.addTask(task);
		assertEquals(1, taskList2.getTasks().size());

		assertEquals("School", task.getTaskListName());
		task.completeTask();
		assertEquals(1, taskList1.getTasks().size());
		assertEquals(1, taskList2.getTasks().size());

	}

	/**
	 * Test method for {@link edu.ncsu.csc216.wolf_tasks.model.tasks.Task#clone()}.
	 * 
	 * @throws CloneNotSupportedException if task is not cloneable
	 */
	@Test
	final void testClone() throws CloneNotSupportedException {
		Task task = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));

		Exception e = assertThrows(CloneNotSupportedException.class, () -> task.clone());

		assertEquals("Cannot clone.", e.getMessage());
		TaskList taskList = assertDoesNotThrow(() -> new TaskList("School", 0));
		task.addTaskList(taskList);
		assertNotEquals(task, task.clone());
	}

	/**
	 * Test method for
	 * {@link edu.ncsu.csc216.wolf_tasks.model.tasks.Task#toString()}.
	 */
	@Test
	final void testToString() {
		Task task = assertDoesNotThrow(() -> new Task("Read Project 2 Requirements", "Read Project 2 requirements \n"
				+ "(https://pages.github.ncsu.edu/engr-csc216-staff/CSC216-SE-Materials/projects/project2/project2-part1.html)\n"
				+ "and identify candidate classes and methods.", false, false));
		assertEquals("* Read Project 2 Requirements\n" + "Read Project 2 requirements \n"
				+ "(https://pages.github.ncsu.edu/engr-csc216-staff/CSC216-SE-Materials/projects/project2/project2-part1.html)\n"
				+ "and identify candidate classes and methods.", task.toString());

		Task task2 = assertDoesNotThrow(() -> new Task("Go to lecture",
				"Watch lectures associated with HW7 by March 31", true, true));
		assertEquals("* Go to lecture,recurring,active\n" + "Watch lectures associated with HW7 by March 31",
				task2.toString());
		
		Task task3 = assertDoesNotThrow(() -> new Task("Go to lecture",
				"Watch lectures associated with HW7 by March 31", false, true));
		assertEquals("* Go to lecture,active\n" + "Watch lectures associated with HW7 by March 31",
				task3.toString());
		
		Task task4 = assertDoesNotThrow(() -> new Task("Go to lecture",
				"Watch lectures associated with HW7 by March 31", true, false));
		assertEquals("* Go to lecture,recurring\n" + "Watch lectures associated with HW7 by March 31",
				task4.toString());

	}

}
