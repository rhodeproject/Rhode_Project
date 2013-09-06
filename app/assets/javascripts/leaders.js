$('document').ready(function(){
   $('.gravatar-leader').hover(function(){
       $(this).attr('src',$(this).attr('src').replace(/(s=)[^\&]+/, '$1' + '125'));
   }, function(){
       $(this).attr('src',$(this).attr('src').replace(/(s=)[^\&]+/, '$1' + '55'));
   });
});
