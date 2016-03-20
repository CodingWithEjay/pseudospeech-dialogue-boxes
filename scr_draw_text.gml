#define scr_draw_text
// scr_draw_text
//   argument0 : The calling object
//   argument1 : A ds_list of strings to be displayed in succession
//   argument2 : String position within this dialogue sequence
// Draws dialogue to a text box

// Creates the textbox object, obj_text
boxText = instance_create(view_xview, view_yview, obj_text);

with (boxText) {
  caller = argument0;
  listStrings = argument1;
  posDialogue = argument2;

  // Find the text for this particular position of the dialogue
  stringText = ds_list_find_value(argument1, ds_list_size(listStrings) - posDialogue);
}
