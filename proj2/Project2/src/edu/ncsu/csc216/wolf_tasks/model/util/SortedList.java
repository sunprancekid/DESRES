package edu.ncsu.csc216.wolf_tasks.model.util;

/**
 * The SortedList class is used to create list of generic objects that are in
 * sorted order. The objects stored in the list must implement the Comparable
 * interface in order for them to be stored in the correct order. The SortedList
 * is implemented as a linked list.
 * 
 * @param <E> general type
 * @author Matthew A Dorsey (madorse2@ncsu.edu)
 *
 */
public class SortedList<E extends Comparable<E>> implements ISortedList<E> {

	/** first node in linked list */
	private ListNode front;
	/** number of elements in list */
	private int size;

	/**
	 * Initializes object to an empty list of linked nodes
	 */
	public SortedList() {
		setSize(0);
		front = null;
	}

	/**
	 * sets size to value passed as parameter
	 * 
	 * @param size value to set size parameter to
	 * 
	 * @throws IllegalArgumentException if size parameter is less than 0
	 */
	private void setSize(int size) {
		if (size < 0)
			throw new IllegalArgumentException();
		this.size = size;
	}

	/**
	 * Adds the element to the list in sorted order.
	 * 
	 * @param element element to add
	 * @throws NullPointerException     if element is null
	 * @throws IllegalArgumentException if element cannot be added because it
	 *                                  already exists in the list
	 */
	@Override
	public void add(E element) {
		// determine that the element can be added to the list
		if (element == null) throw new NullPointerException("Cannot add null element.");
		if (contains(element)) throw new IllegalArgumentException("Cannot add duplicate element.");
		// add element to list
		ListNode current = front;
		if (current == null) {
			front = new ListNode(element);
		} else if (element.compareTo(current.data) < 0) {
			// add to the front of the list
			front = new ListNode(element, front);
		} else {
			// add to the middle or back of the list
			while (current.next != null && current.next.data.compareTo(element) < 0) {
				current = current.next;
			}
			current.next = new ListNode(element, current.next);
		}
		size++;
	}

	/**
	 * Returns the element from the given index. The element is removed from the
	 * list.
	 * 
	 * @param idx index to remove element from
	 * @return element at given index
	 * @throws IndexOutOfBoundsException if the index is out of bounds for the list
	 */
	@Override
	public E remove(int idx) {
		// determine that the index is in the bounds of the list
		if (idx < 0 || idx >= size) throw new IndexOutOfBoundsException("Invalid index.");
		// remove the element from the list
		E value = null;
		if (idx == 0) {
			// element to remove is at the front of the stack
			value = front.data;
			front = front.next;
		} else {
			// element to remove is somewhere else in the stack
			ListNode current = front;
			for (int i = 0; i < idx - 1; i++) {
				current = current.next;
			}
			value = current.next.data;
			current.next = current.next.next;
		}
		size--;
		return value;
	}

	/**
	 * Returns true if the element is in the list.
	 * 
	 * @param element element to search for
	 * @return true if element is found
	 */
	@Override
	public boolean contains(E element) {
		boolean contains = false;
		if (front != null) {
			ListNode current = front;
			for (int i = 0; i < size; i++) {
				contains = contains || current.data.compareTo(element) == 0;
				current = current.next;
			}
		}
		return contains;
	}

	/**
	 * Returns the element at the given index.
	 * 
	 * @param idx index of the element to retrieve
	 * @return element at the given index
	 * @throws IndexOutOfBoundsException if the index is out of bounds for the list
	 */
	@Override
	public E get(int idx) {
		// determine that the index is in the bounds of the list
		if (idx < 0 || idx >= size) throw new IndexOutOfBoundsException("Invalid index.");
		// retrieve the element from the list
		E value = null;
		if (idx == 0) {
			value = front.data;
		} else {
			ListNode current = front;
			for (int i = 0; i < idx - 1; i++) {
				current = current.next;
			}
			value = current.next.data;
		}
		return value;
	}

	/**
	 * returns the number of elements in the list
	 * 
	 * @return number of elements in list
	 */
	@Override
	public int size() {
		return size;
	}

	/**
	 * The ListNode class is used to implement the linked list methodology.
	 * 
	 * @author Matthew A Dorsey (madorse2@ncsu.edu)
	 *
	 */
	private class ListNode {

		/** field that contains data of a generic type */
		public E data;
		/** field that links one node to the next */
		public ListNode next;

		/**
		 * Constructs list node
		 * 
		 * @param data data of generic type E
		 * @param next node that points to next node in list
		 */
		public ListNode(E data, ListNode next) {
			this.data = data;
			this.next = next;
		}

		/**
		 * Construst list node when provided no next node
		 * 
		 * @param data generic data stored in list
		 */
		public ListNode(E data) {
			this(data, null);
		}
	}

}
