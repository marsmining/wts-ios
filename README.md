WTS iOS App
===========

Simple app which displays a list of shopping districts via
a table view controliler. When you select a district you can
view the images for that district within a page view
controller.

Info
----

* on launch, asynchronously fetches json via http and syncs
  data to core data db
* for each image in core data db, download thumbnail to the
  apps cache dir asynchronously, if the file does not exist
* uses custom table view cell subclass and nib file
* image viewing code adapted from Apple photo scroller sample
  app
