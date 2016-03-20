# Pseudospeech Dialogue Boxes

## About

This is a GML object + script implementation of dialogue boxes with pseudospeech. This effect can be found in games like Undertale and all of the Animal Crossing titles.

## How it Works

### obj_text

This is the object that actually creates the dialogue box on the view and plays the pseudospeech sound.

**Create**

In addition to initializing various stylistic things, the Create event of obj_text creates stringPrinted, which is the dynamic string shown on the dialogue box. The speed at which the dialogue proceeds is also initialized at 3, but this can be changed. Know that this denotes the number of frames passed in the room between letter of dialogue; so since our room's speed is set to 60 FPS, this means a letter will be shown (and a sound will be played) every 3/60 seconds. Finally

```gml
// Initialize position and stringPrinted
position = 0;
stringPrinted = "";

// Set the speed at which the text appears
spd = 3;
```

**Alarm[0]**

The alarm advances stringPrinted 1 character along stringText, the full text to be displayed, at every iteration. The actual speech playing part of this event is shown in the code below. Essentially, if there is a newline or stop in stringText, the dialogue box will slow down its speed for 1 character, making for "natural" sounding breaks in the pseudospeech. If there is no newline or stop, the alarm will either begin playing the speech sound or stop the speech sound and play it anew.

```gml
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
```

**Release X-key**

This will display the entirety of the text to the screen all at once, allowing users to skip parts of conversations at will.

**Release Z-key**

This either proceeds to the next line of text within the dialogue sequence, or it ends the dialogue sequence entirely. Note that, if all the text has been displayed, input/output is cleared for the caller. This is to prevent the user's pressing of Z to interact with obj_text again, making for an infinite loop of text.

```gml
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
```

## Example

This repository includes an example that shows basic usage of the script, as well as other things like conditions for different branches of dialogue. However, since I developed this on a Mac, there's no .gmx unfortunately; you'll have to settle for a .gmk file.

## Usage

To use this, simply drop obj_text and scr_draw_text into your project. From there, whenever you want a user's interaction with something (e.g. a signpost) to create dialogue, make that something (e.g. the signpost) call scr_draw_text in the following manner:

```gml
scr_draw_text(id, scr_sign_dialogue("example"), ds_list_size(scr_sign_dialogue("example")));
```

where scr_draw_text contains the following:

```gml
// scr_sign_dialogue
//   argument0 : string that indicates which dialogue sequence to return
// Contains all the dialogue for obj_sign
name = argument0;
dialogue = ds_list_create();

switch(name) {
  case "example":
    ds_list_add(dialogue, "Here's a first line of dialogue.");
    ds_list_add(dialogue, "Here's a second line of dialogue.");
    ds_list_add(dialogue, "Here's a third line of dialgoue.");
    return dialogue;
    break;
  default: break;
}
```

License
-------

See `LICENSE` file.
