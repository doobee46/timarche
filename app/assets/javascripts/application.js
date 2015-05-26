// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-onboarded-0.0.8.min.js
//= require wufoo.js
//= require social-share-button
//= require turbolinks
//= require chosen-jquery
//= require messages
//= require_tree .

var pollActivity = function(){
    $.ajax({
        url: Routes.activities_path({format: 'json', since: window.lastFetch}),
        type:"GET",
        datatype:"json",
        success:function(data){
            window.lastFetch = Math.floor((new.Date).getTime() / 1000);
            console.log(data);
        }
    });
}

window.pollInterval = window.setInterval(pollActivity,5000)

$(document).ready ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url and $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html '<img src="/assets/spin.gif" alt="Loading..." title="Loading..." />'
        return $.getScript(url)
      return
    return $(window).scroll()
  return

