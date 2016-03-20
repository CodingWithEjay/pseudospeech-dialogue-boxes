// If all the text has been displayed,
if (finished == true) {
  // Clear the input/output for the caller
  with (caller) {
    io_clear();
  }

  // If there are remaining strings in this dialogue sequence, continue
  if (posDialogue > 1) {
    posDialogue -= 1;
    scr_draw_text(caller, listStrings, posDialogue);
  }

  // Destroy this instance regardless
  instance_destroy();
}
