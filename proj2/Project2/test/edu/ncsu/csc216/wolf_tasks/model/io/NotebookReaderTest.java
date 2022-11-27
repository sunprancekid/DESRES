package edu.ncsu.csc216.wolf_tasks.model.io;

import static org.junit.jupiter.api.Assertions.*;

import java.io.File;

import org.junit.jupiter.api.Test;

import edu.ncsu.csc216.wolf_tasks.model.notebook.Notebook;

class NotebookReaderTest {

	/** valid notebook file */
	private final String notebookFile0 = "test-files/notebook0.txt";
	/** valid notebook file */
	private final String notebookFile1 = "test-files/notebook1.txt";
	/** valid notebook file */
	private final String notebookFile2 = "test-files/notebook2.txt";
	/** invalid notebook file */
	private final String notebookFile3 = "test-files/notebook3.txt";
//	/** invalid notebook file */
//	private final String notebookFile4 = "test-files/notebook4.txt";
//	/** invalid notebook file */
//	private final String notebookFile5 = "test-files/notebook5.txt";
//	/** invalid notebook file */
//	private final String notebookFile6 = "test-files/notebook6.txt";
	/// ** invalid notebook file */
	// private final String notebookFile7 = "test-files/notebook7.txt";
	/** list of valid notebook files */
	private final String[] validNotebookFiles = { notebookFile0, notebookFile1, notebookFile2 };
	/** list of invalid notebook files */
	private final String[] invalidNotebookFiles = { notebookFile3  }; // notebookFile7,  notebookFile5, notebookFile4, notebookFile6,

	/**
	 * Test creating notebooks from files that have been properly formatted
	 */
	@Test
	void testReadValidFiles() {
		// create notebook
		Notebook nb;

		// test the first file
		File validFile1 = new File(validNotebookFiles[0]);
		nb = assertDoesNotThrow(() -> NotebookReader.readNotebookFile(validFile1));
		assertEquals(1, nb.getTaskListsNames().length);

		// test the second file
		File validFile2 = new File(validNotebookFiles[1]);
		nb = assertDoesNotThrow(() -> NotebookReader.readNotebookFile(validFile2));
		assertEquals(4, nb.getTaskListsNames().length);

		// test the third file
		File validFile3 = new File(validNotebookFiles[2]);
		nb = assertDoesNotThrow(() -> NotebookReader.readNotebookFile(validFile3));
		assertEquals(4, nb.getTaskListsNames().length);

	}

	/**
	 * Test that creating a notebook from a file that is improperly formatted throws
	 * an exception.
	 */
	@Test
	void testReadInvalidFiles() {
		// each of the files in the list should fail at constructing a notebook
		for (int i = 0; i < invalidNotebookFiles.length; i++) {
			try {
				File invalidFile = new File(invalidNotebookFiles[i]);
				Notebook nb = NotebookReader.readNotebookFile(invalidFile);
				nb.getCurrentTaskList();
				fail(invalidNotebookFiles[i] + " should not pass.");
			} catch (IllegalArgumentException e) {
				assertEquals(e.getMessage(), "Unable to load file.");
			}
		}
	}

}
