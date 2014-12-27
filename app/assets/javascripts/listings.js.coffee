# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

url = document.location.toString()
$(".nav-tabs a[href=#" + url.split("#")[1] + "]").tab "show"  if url.match("#")

# Change hash for page-reload
$(".nav-tabs a").on "shown", (e) ->
  window.location.hash = e.target.hash
  return
