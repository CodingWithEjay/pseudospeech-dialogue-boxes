// Add to stringPrinted
stringPrinted = string_copy(stringText, 0, position);

// Get the char at the current position
charCurrent = string_char_at(stringText, position);

// If the char at the current position is a newline or stop,
if (charCurrent == "#" || charCurrent == "," || charCurrent == "."
  || charCurrent == "?" || charCurrent == "!") {
  // Make the alarm wait longer this iteration
  spd = 12;

  // Stop playing the speech sound
  sound_stop(sound_speech);
}
else {
  // Otherwise, advance with a fast speed
  spd = 3;

  // If the speech sound is already playing,
  if (sound_isplaying(sound_speech)) {
    // Restart it
    sound_stop(sound_speech);
    sound_play(sound_speech);
  }
  else {
    // Otherwise, play the speech sound
    sound_play(sound_speech);
  }
}

// If more remains to be printed,
if (position < string_length(stringText)) {
  // Advance the position
  position += 1;
}
else {
  // Otherwise, exit
  finished = true;
  exit;
}

// Start up this alarm again at the appropriate speed
alarm[0] = spd;
