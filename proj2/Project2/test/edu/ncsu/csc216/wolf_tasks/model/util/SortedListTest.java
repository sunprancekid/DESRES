package edu.ncsu.csc216.wolf_tasks.model.util;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class SortedListTest {

	/**
	 * This unit test tests the construction of sorted list objects.
	 */
	@Test
	final void testSortedListConstruction() {
		// construct a sorted list
		SortedList<String> list = new SortedList<String>();

		// determine that the list has been constructed properly
		assertEquals(0, list.size());
		assertThrows(IndexOutOfBoundsException.class, () -> list.get(0));
	}

	/**
	 * This unit test tests adding elements to the sorted list object
	 */
	@Test
	final void testSortedListAddAndRemove() {
		// construct a sorted list
		SortedList<String> list = new SortedList<String>();

		// add elements to the sorted list
		list.add("a");
		list.add("f");
		list.add("d");
		list.add("c");
		list.add("b");
		assertEquals(5, list.size());
		
		// check that adding a null element throws a null pointer exception
		assertThrows(NullPointerException.class, () -> list.add(null));
		
		// check that adding an element already in the list throws an IllegalArgumentsException
		assertThrows(IllegalArgumentException.class, () -> list.add("a"));

		// check that the elements have been added in the correct order
		assertEquals("a", list.get(0));
		assertEquals("b", list.get(1));
		assertEquals("c", list.get(2));
		assertEquals("d", list.get(3));
		assertEquals("f", list.get(4));

		// remove elements from the list and determine that the correct order has still
		// been maintained
		list.remove(1);
		assertEquals("a", list.get(0));
		assertEquals("c", list.get(1));
		assertEquals("d", list.get(2));
		assertEquals("f", list.get(3));
		
		list.remove(2);
		assertEquals("a", list.get(0));
		assertEquals("c", list.get(1));
		assertEquals("f", list.get(2));
		
		list.remove(0);
		assertEquals("c", list.get(0));
		assertEquals("f", list.get(1));
		
		list.remove(1);
		assertEquals("c", list.get(0));
	}

}
