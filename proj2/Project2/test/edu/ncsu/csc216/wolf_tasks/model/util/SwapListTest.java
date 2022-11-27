package edu.ncsu.csc216.wolf_tasks.model.util;

import static org.junit.Assert.assertThrows;
import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;

class SwapListTest {

	@Test
	final void testSwapList() {
		SwapList<String> sList = new SwapList<String>();

		sList.add("fisrt string");
		sList.add("second string");
		sList.add("third string");

		assertEquals("third string", sList.get(2));

		// check index
		Exception e = assertThrows(IndexOutOfBoundsException.class, () -> sList.get(4));
		assertEquals("Invalid index.", e.getMessage());
		
		//check Capacity
		sList.add("1 string");
		sList.add("2 string");
		sList.add("3 string");
		sList.add("4 string");
		sList.add("5 string");
		sList.add("6 string");
		sList.add("7 string");
		sList.add("8 string");
		sList.add("9 string");
		sList.add("10 string");
		sList.add("11 string");
		sList.add("12 string");
		assertEquals(15, sList.size());

	}

	@Test
	final void testMoveUp() {
		SwapList<String> sList = new SwapList<String>();

		sList.add("fisrt string");
		sList.add("second string");
		sList.add("third string");

		assertEquals("third string", sList.get(2));
		sList.moveUp(2);
		assertEquals("third string", sList.get(1));
		assertEquals("second string", sList.get(2));
	}

	@Test
	final void testMoveDown() {
		SwapList<String> sList = new SwapList<String>();

		sList.add("fisrt string");
		sList.add("second string");
		sList.add("third string");

		assertEquals("fisrt string", sList.get(0));
		sList.moveDown(0);
		assertEquals("fisrt string", sList.get(1));
		assertEquals("second string", sList.get(0));
	}

	@Test
	final void testMoveToFront() {
		SwapList<String> sList = new SwapList<String>();

		sList.add("fisrt string");
		sList.add("second string");
		sList.add("third string");

		assertEquals("third string", sList.get(2));
		sList.moveToFront(2);
		assertEquals("third string", sList.get(0));
		assertEquals("fisrt string", sList.get(1));
		assertEquals("second string", sList.get(2));
	}

	@Test
	final void testMoveToBack() {
		SwapList<String> sList = new SwapList<String>();

		sList.add("fisrt string");
		sList.add("second string");
		sList.add("third string");

		assertEquals("fisrt string", sList.get(0));
		sList.moveToBack(0);
		assertEquals("third string", sList.get(1));
		assertEquals("fisrt string", sList.get(2));
		assertEquals("second string", sList.get(0));
	}

}
