package edu.ncsu.csc216.wolf_tasks.model.tasks;

import static org.junit.Assert.assertThrows;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class AbstractTaskListTest {

	@Test
	final void testAbstractTaskList() {
		AbstractTaskList atl = assertDoesNotThrow(() -> new TaskList("School", 0));
		assertEquals("School", atl.getTaskListName());
		assertEquals(0, atl.getCompletedCount());
		assertThrows(IllegalArgumentException.class, () -> new TaskList(null, 0));

	}

	@Test
	final void testGetTask() {
		AbstractTaskList atl = assertDoesNotThrow(() -> new TaskList("School", 0));
		Task task1 = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		Task task2 = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));
		Task task3 = assertDoesNotThrow(() -> new Task("Task Name", "Task Detail", true, true));

		atl.addTask(task1);
		atl.addTask(task2);
		atl.addTask(task3);
		assertEquals(task2, atl.getTask(1));
	}
 
}
