.. _keyboard:

Keyboard Component
-------------------------------

The Keyboard component can be used to collect responses from a participant. 

By not storing the key press and checking the `forceEndTrial` box it can be used simply to end a :ref:`Routine <Routines>`

Parameters
~~~~~~~~~~~~~~

name : string
    Everything in a PsychoPy experiment needs a unique name. The name should contain only letters, numbers and underscores (no punctuation marks or spaces).

start : float or integer
    The time that the keyboard should first get checked. See :ref:`startStop` for details.

stop :
    When the keyboard is no longer checked. See :ref:`startStop` for details.

force end routine
    If this box is checked then the :ref:`Routine <Routines>` will end as soon as one of the `allowed` keys is pressed.

Data
====
What information to save, how to lay it out and when to save it.

allowed keys : list
    A list of allowed keys can be specified here, e.g. ['m','z','1','2'], or the name of a variable holding such a list. If this box is left blank then any key that is pressed will be read. Only `allowed keys` count as having been pressed; any other key will not be stored and will not force the end of the Routine. Note that key names (even for number keys) should be given in single quotes, separated by commas. Cursor control keys can be accessed with 'up', 'down', and so on; the space bar is 'space'. To find other special keys, run the Coder Input demo, "what_key.py", press the key, and check the Coder output window. 

store : last key, first key, all keys, nothing
    Which key press, if any, should be stored; the first to be pressed, the last to be pressed or all that have been pressed. If the key press is to force the end of the trial then this setting is unlikely to be necessary, unless two keys happen to be pressed in the same video frame. The response time will also be stored if a keypress is recorded. This time will be taken from the start of keyboard checking (e.g. if the keyboard was initiated 2 seconds into the trial and a key was pressed 3.2s into the trials the response time will be recorded as 1.2s).

store correct : bool
    Check this box if you wish to store whether or not this key press was correct. If so then fill in the next box that defines what would constitute a correct answer e.g. left, 1 or `$corrAns` (note this should not be in inverted commas). This is given as Python code that should return True (1) or False (0). Often this correct answer will be defined in the settings of the :ref:`Loops`.

discard previous : bool
    Check this box to ensure that only key presses that occur during this keyboard checking period are used. If this box is not checked a keyboard press that has occurred before the start of the checking period will be interpreted as the first keyboard press. For most experiments this box should be checked.
        
.. seealso::

    API reference for :doc:`psychopy.event</api/event>`
     
