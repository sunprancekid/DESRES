package edu.ncsu.csc216.wolf_tasks.model.util;

/**
 * This class implements the ISwapList interface
 * 
 * @author mauro
 *
 * @param <E> type of data to store in the swap list
 */
public class SwapList<E> implements ISwapList<E> {
	/** Initial Array capacity */
	private static final int INITIAL_CAPACITY = 10;
	/** Array use to hold the data */
	private E[] list;
	/** size of the data into the array */
	private int size;

	/**
	 * Default constructor used to initialize the fields to the default values and
	 * set the Array with generich parameter to 10.
	 */
	@SuppressWarnings("unchecked")
	public SwapList() {

		list = (E[]) new Object[INITIAL_CAPACITY];
		size = 0;
	}

	/**
	 * This method add the element at the end of the list. It uses the private
	 * method checkCapacity to check if htere is enough space to add the new element
	 * ot the list.
	 * 
	 * @param element element to add
	 * @throws NullPointerException if element is null
	 */
	@Override
	public void add(E element) {
		if (element == null) {
			throw new NullPointerException("Cannot add null element.");
		}
		checkCapacity(size + 1);

		list[size++]  = element;
		
	}

	/**
	 * This method returns the element from the list at the given index. It uses the
	 * private method checkIndex to check if the index is in the array boundries.
	 * 
	 * If the index is found, the for loop will shift left all the element to the
	 * left of the given index. It will set the element at size-1 to null.
	 * 
	 * @param idx element to remove
	 * @return the element at the given index
	 */
	@Override
	public E remove(int idx) {
		// check if the index given is in the boundries
		checkIndex(idx);

		E element = list[idx];
		// left shift on the array
		for (int i = idx; i < size; i++) {
			list[i] = list[i + 1];
		}
		// set the last element of the arrayList to null
		list[size - 1] = null;
		// reduce the size of the array
		size--;
		return element;

	}

	/**
	 * This method moves up the element at the given index. It uses the private
	 * method checkIndex to check if the index is in the array boundries.
	 * 
	 * @param idx index of the element that will be move up
	 * @throws IndexOutOfBoundsException if the size of the list is equal to 0
	 */
	@Override
	public void moveUp(int idx) {
		// check if the size is equal to 0
		if (size == 0) {
			throw new IndexOutOfBoundsException("Invalid index.");
		}
		// check if the index given is in the boundries
		checkIndex(idx);
		// the index is not equal to 0, the element at the given index will be moved up
		if (idx != 0) {

			E element = list[idx];
			list[idx] = list[idx - 1];
			list[idx - 1] = element;
		}

	}

	/**
	 * This method moves down the element at the given index. It uses the private
	 * method checkIndex to check if the index is in the array boundries.
	 * 
	 * @param idx index of the element that will be move down
	 * @throws IndexOutOfBoundsException if the size of the list is equal to 0
	 */
	@Override
	public void moveDown(int idx) {
		// check if the size is equal to 0
		if (size == 0) {
			throw new IndexOutOfBoundsException("Invalid index.");
		}
		// check if the index given is in the boundries
		checkIndex(idx);
		// the index is not equal to size -1, the element at the given index will be
		// moved down
		if (idx != size - 1) {

			E element = list[idx];
			list[idx] = list[idx + 1];
			list[idx + 1] = element;
		}

	}

	/**
	 * This method moves to the front of the list the element at the given index. It
	 * uses the private method checkIndex to check if the index is in the array
	 * boundries. The for loop moves/shifts the element at the given index to index
	 * 0, shifting back all the elments in the list from index 0 to thegiven index
	 * 
	 * @param idx index of the element that will be move to the front (index 0) of
	 *            the list
	 * @throws IndexOutOfBoundsException if the size of the list is equal to 0
	 */
	@Override
	public void moveToFront(int idx) {
		// check if the size is equal to 0
		if (size == 0) {
			throw new IndexOutOfBoundsException("Invalid index.");
		}
		// check if the index given is in the boundries
		checkIndex(idx);
		// moves the element at the given index to index 0, shifting back all the
		// elments in the list from index 0 to thegiven index
		for (int i = idx; i >= 1; i--) {

			E element = list[i];
			list[i] = list[i - 1];
			list[i - 1] = element;

		}
	}

	/**
	 * This method moves to the back of the list the element at the given index. It
	 * uses the private method checkIndex to check if the index is in the array
	 * boundries. The for loop moves/shifts the element at the given index to index
	 * size-1, shifting forward all the // elments in the list from index size-1 to
	 * the given index.
	 * 
	 * @param idx index of the element that will be move to the back (index size-1)
	 *            of the list
	 * @throws IndexOutOfBoundsException if the size of the list is equal to 0
	 */
	@Override
	public void moveToBack(int idx) {
		// check if the size is equal to 0
		if (size == 0) {
			throw new IndexOutOfBoundsException("Invalid index.");
		}
		// check if the index given is in the boundries
		checkIndex(idx);
		// moves the element at the given index to index size-1, shifting forward all
		// the
		// elments in the list from index size-1 to the given index.
		for (int i = idx; i < size - 1; i++) {

			E element = list[i];
			list[i] = list[i + 1];
			list[i + 1] = element;

		}
	}

	/**
	 * This method check through the entire array from 0 to size the elment at hte
	 * given index and returns it. It uses the private method checkIndex to check if
	 * the index is in the array boundries.
	 * 
	 * @param idx index of the element to get
	 * @return element at the given index
	 */
	@Override
	public E get(int idx) {
		// check if the index given is in the boundries
		checkIndex(idx);
		// check through the array from 0 to size and return the elemnt at the given
		// index
		for (int i = 0; i < size; i++) {
			if (i == idx) {
				return list[i];
			}
		}
		return null;
	}

	/**
	 * This method returns the number of elements present in the list.
	 * 
	 * @return number of elements in the list
	 */
	@Override
	public int size() {
		 
		return size;
	}

	/**
	 * This method checks if the max capacity of the list is reached. he Array
	 * lenght will be doubled if the idx is grather than the lenght of the Array
	 * 
	 * @param idx capacity of the list
	 */
	private void checkCapacity(int idx) {

		if (idx > list.length) {
			@SuppressWarnings("unchecked")
			// The Array lenght will be doubled if the idx is grather than the lenght of the
			// Array
			E[] list2 = (E[]) new Object[list.length * 2];
			// iterate through the Array
			for (int i = 0; i < size; i++) {

				list2[i] = list[i];
			}

			list = list2;
		}

	}

	/**
	 * This method checks if the index of the list is valid
	 * 
	 * @param idx index of the list
	 */
	private void checkIndex(int idx) {
		if (idx < 0 || idx >= size) {
			throw new IndexOutOfBoundsException("Invalid index.");
		}
	}
}
