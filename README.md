= What's that =

A Latex boilerplate, to ease the pain of writing docs and reports. (Sometimes
a programmer's gotta do what a programmer's gotta do what a programmer's gotta do).

Tested under Ubuntu 10.04


= HowTo =

 - Fill in the infos about your document in DocInfos.mk
 - Place your tex files in the "tex" folder, and name them in the order you want
them to be concatenated in the final document (eg you can divide your documents
in sections named 1.section\_one.tex and so on).
 - Place your images in the pics folder, and refer to this place in your tex files by
 using the `\PIXPATH` command.
 - `make` to build your report. `make clean` to clean the mess while keeping the
 generated pdf around, `make cleanall` to wipe out everything.


= Things to know =

 - This boilerplate is intended to work with utf-8 encoded files only. That's
 something that could be improved in the future.


= Shoot out =

This boilerplate is inspired by the latex tree from Raphael Lizé
(https://github.com/time0ut)
