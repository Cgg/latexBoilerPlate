What's that
-----------

A Latex boilerplate, helping with the task of writing reports in LaTeX.

Tested under Ubuntu 10.04, 12.04. (It should work if you install texlive).


HowTo
-----

 - Fill in the infos about your document in DocInfos.mk
 - Place your tex files in the "tex" folder, and name them in the order you want
them to be concatenated in the final document (eg you can divide your documents
in sections named 1.section\_one.tex and so on).
 - Place your images in the pics folder, and refer to this place in your tex files by
 using the `\PIXPATH` command.
 - `make` to build your report. `make clean` to clean the mess while keeping the
 generated pdf around, `make cleanall` to wipe out everything.


Things to know
--------------

 - This boilerplate is intended to work with utf-8 encoded files only. That's
 something that could be improved in the future.


Remerciements
-------------

This boilerplate is inspired by the latex tree from Raphael Lizé
(https://github.com/time0ut)
